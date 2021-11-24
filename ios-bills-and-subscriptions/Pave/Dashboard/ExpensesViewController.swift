import UIKit


protocol ExpensesDashboardView {
	func updateData()
	func showError(_ error: Error)
}


/// Shows expenses. Contains graph and cells with information about payments.
class ExpensesViewController: UIViewController, ExpensesDashboardView {
	
	enum Sections: Int, RawRepresentable, CaseIterable {
		case graph = 0
		case bills = 1
		case subscriptions = 2
		
		var reuseId: String {
			return "reuse_id_\(self.rawValue)"
		}
	}
		
	private lazy var presenter: DashboardPresenterProtocol = ExpensesDashboardPresenter(expensesView: self)
	
	// MARK: - UI
	
	private var headerReuseId = "ExpendituresSectionHeaderView"

	private lazy var tableView: UITableView = {
		let t = UITableView(frame: .zero)
		t.translatesAutoresizingMaskIntoConstraints = false
		t.register(ExpenditureCell.self, forCellReuseIdentifier: Sections.bills.reuseId)
		t.register(ExpenditureCell.self, forCellReuseIdentifier: Sections.subscriptions.reuseId)
		
		t.sectionFooterHeight = 0
		t.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: t.frame.width, height: 0)))

		return t
	}()
	
	private lazy var loader: UIActivityIndicatorView = {
		let loader = UIActivityIndicatorView()
		return loader
	}()
	
	var refreshControl = UIRefreshControl()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(tableView)
		tableView.dataSource = self
		tableView.delegate = self
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
			tableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
		])
		
		refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
		refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
		tableView.addSubview(refreshControl)
		
		tableView.addSubview(loader)
		loader.center = view.center
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		loader.startAnimating()
		presenter.getExpenses(for: Date())
	}
	
	@objc func refresh(_ sender: AnyObject) {
		refreshControl.endRefreshing()
		tableView.reloadData()
	}
	
	// MARK: - ExpensesDashboardView
	
	func updateData() {
		DispatchQueue.main.async {
			self.loader.stopAnimating()
			self.tableView.reloadData()
		}
	}
	
	func showError(_ error: Error) {
		DispatchQueue.main.async {
			self.loader.stopAnimating()
			let errorText: String? = {
				if let error = error as? ErrorWithDescription {
					return error.errorDescription
				} else {
					return error.localizedDescription
				}
			}()
			let alert = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
				self.presenter.getExpenses(for: Date())
			}))
			self.present(alert, animated: true, completion: nil)
		}
	}
}


extension ExpensesViewController: UITableViewDataSource, UITableViewDelegate {
	func numberOfSections(in tableView: UITableView) -> Int {
		return Sections.allCases.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case Sections.graph.rawValue:
			return 1
		case Sections.bills.rawValue:
			return presenter.currentMonthExpenses.bills.count
		case Sections.subscriptions.rawValue:
			return presenter.currentMonthExpenses.subscriptions.count
		default:
			fatalError("Section \(section) not implemented")
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case Sections.graph.rawValue:
			let cell = GraphCell()
			cell.setValuesForGraph([presenter.previousMonthExpenses, presenter.currentMonthExpenses])
			let amount = presenter.currentMonthExpenses.total.string()
			cell.setTitle("You paid \(amount) for bills and subscriptions this month")
			return cell
		case Sections.bills.rawValue:
			let item = presenter.currentMonthExpenses.bills[indexPath.row]
			let cell = tableView.dequeueReusableCell(withIdentifier: Sections.bills.reuseId, for: indexPath) as! ExpenditureCell
			configureCell(cell, with: item)
			return cell
		case Sections.subscriptions.rawValue:
			let item = presenter.currentMonthExpenses.subscriptions[indexPath.row]
			let cell = tableView.dequeueReusableCell(withIdentifier: Sections.subscriptions.reuseId, for: indexPath) as! ExpenditureCell
			configureCell(cell, with: item)
			return cell
		default:
			fatalError("Section \(indexPath.section) not implemented")
		}
	}
	
	private func configureCell(_ cell: ExpenditureCell, with model: Expenditure) {
		cell.setMerchant(model.normalizedMerchantName)
		cell.setAmount(model.lastAmount)
		cell.setLastDeltaAmount(model.deltaAmount)
		cell.setImage(model.merchantNameAbbreviation.image())
		cell.setSubtitle(model.normalizedFrequency.rawValue.byCapitalizingFirstLetter())
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch indexPath.section {
		case Sections.graph.rawValue:
			return 220
		default:
			return 70
		}
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = ExpendituresSectionHeaderView(frame: .zero)
		view.backgroundColor = UIColor(red: 217.0 / 255.0, green: 217.0 / 255.0, blue: 217.0 / 255.0, alpha: 1)
		switch section {
		case Sections.bills.rawValue:
			view.setTitle("Bills")
			let total = presenter.currentMonthExpenses.billsTotal.string()
			view.setSubtitle("You paid \(total) for bills")
		case Sections.subscriptions.rawValue:
			view.setTitle("Subscriptions")
			let total = presenter.currentMonthExpenses.subscriptionsTotal.string()
			view.setSubtitle("You paid \(total) for subscriptions")
		default:
			let v = UIView(frame: CGRect(origin: .zero, size: CGSize(width: tableView.frame.width, height: 0)))
			return v
		}
		return view
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		switch section {
		case Sections.bills.rawValue:
			return 60
		case Sections.subscriptions.rawValue:
			return 60
		default:
			return 0
		}
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		// we add ChartViewController to cell
		if indexPath.section == Sections.graph.rawValue,
		   let cell = cell as? GraphCell {
			addChild(cell.chartViewController)
			cell.chartViewController.didMove(toParent: self)
		}
	}
	
	func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		// we remove ChartViewController from cell
		if indexPath.section == Sections.graph.rawValue,
		   let cell = cell as? GraphCell {
			cell.chartViewController.willMove(toParent: nil)
			cell.chartViewController.removeFromParent()
		}
	}
	
}

