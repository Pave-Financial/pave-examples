import Foundation


protocol DashboardPresenterProtocol {
	func getExpenses(for date: Date)
	
	var currentMonthExpenses: MonthExpenses {get set}
	var previousMonthExpenses: MonthExpenses {get set}
}


class ExpensesDashboardPresenter: DashboardPresenterProtocol {
	
	private var view: ExpensesDashboardView
	private var dataProvider: DataProvider
	
	public var currentMonthExpenses: MonthExpenses = MonthExpenses(monthDate: Date())
	public var previousMonthExpenses: MonthExpenses = MonthExpenses(monthDate: Date().oneMonthAgo)

	init(expensesView: ExpensesDashboardView) {
		view = expensesView
		dataProvider = DataProvider()
	}
	
	func getExpenses(for date: Date) {
		dataProvider.getExpenses() { [weak self] (result: Result<[Expenditure], Error>) in
			guard let self = self else {return}
			switch result {
			case .failure(let error):
				print(error)
				self.view.showError(error)
			case .success(let result):
				let transactionsSortedByDate = result.sorted { $0.lastDate > $1.lastDate }
				transactionsSortedByDate.forEach { print($0) }
				
				guard let monthToShow = transactionsSortedByDate.first?.lastDate else {
					self.view.showError(SimpleError(errorDescription: "You have no transactions"))
					return
				}
				
				let (previousMonthExpenses, currentMonthExpenses) = self.processTwoLastMonthsExpenses(transactionsSortedByDate, currentDate: monthToShow)
				self.currentMonthExpenses = currentMonthExpenses
				self.previousMonthExpenses = previousMonthExpenses
				
				for expenditure in currentMonthExpenses.allExpenditures {
                    switch expenditure.tag {
					case "Subscription":
						self.currentMonthExpenses.subscriptions.append(expenditure)
					default:
						self.currentMonthExpenses.bills.append(expenditure)
					}
				}
				self.view.updateData()
			}
		}
	}
	
	// this function gets expenses for two last month
	private func processTwoLastMonthsExpenses(_ expenses: [Expenditure], currentDate: Date) -> (previousMonth: MonthExpenses, currentMonth: MonthExpenses) {
		
		var currentMonthExpenses = MonthExpenses(monthDate: currentDate)
		var previoustMonthExpenses = MonthExpenses(monthDate: currentDate.oneMonthAgo)
		
		for transaction in expenses {
			// if the transaction is from current month
			if transaction.lastDate.isEqual(to: currentDate, toGranularity: Calendar.Component.month) {
				currentMonthExpenses.allExpenditures.append(transaction)
				do {
					try currentMonthExpenses.total += transaction.lastAmount
				} catch {
					print("skipped adding \(transaction), because it has different currency")
				}
			}
			// if the transaction is from previous month
			if transaction.lastDate.isEqual(to: currentDate.oneMonthAgo, toGranularity: Calendar.Component.month) {
				previoustMonthExpenses.allExpenditures.append(transaction)
				do {
					try previoustMonthExpenses.total += transaction.lastAmount
				} catch {
					print("skipped adding \(transaction), because it has different currency")
				}
			}
		}
		
		return (previoustMonthExpenses, currentMonthExpenses)
	}
}
