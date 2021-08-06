import Foundation

// That class represents expenses for month
struct MonthExpenses {
	var monthDate: Date
	
	var total: MoneyAmount = .zero
	var allExpenditures = [Expenditure]()
	
	var bills = [Expenditure]()
	lazy var billsTotal: MoneyAmount = {
		bills.reduce(into: MoneyAmount.zero) { (result, expenditure) in
			do {
				try result += expenditure.lastTransactionAmount
			} catch {
				return
			}
		}
	}()
	
	var subscriptions = [Expenditure]()
	lazy var subscriptionsTotal = {
		subscriptions.reduce(into: MoneyAmount.zero) { (result, expenditure) in
			do {
				try result += expenditure.lastTransactionAmount
			} catch {
				return
			}
		}
	}()
	
	var monthName: String {
		if monthDate.thisMonth {
			return "This month"
		}
		if monthDate.previousMonth {
			return "Last month"
		}
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM, yyyy"
		return dateFormatter.string(from: self.monthDate)
	}
}
