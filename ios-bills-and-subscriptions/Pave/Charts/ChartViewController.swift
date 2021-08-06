import Charts
import UIKit


/// It's a struct that represents a value of dashboard
/// Map your values into DashboardValues instances and pass them to ChartViewController in setValues(_ :)
struct DashboardValue {
	var barName: String
	var barHeight: Double
}


/// Draws and manages chart
class ChartViewController: UIViewController {
	
	// MARK: - Public
	
	/// Use this method to set values you want to display in the chart.
	/// Chart will update itself when you set these new values
	func setValues(_ bars: [DashboardValue]) {
		let dataEntries: [ChartDataEntry] = bars.enumerated().map { index, bar in
			return BarChartDataEntry(x: Double(index), y: bar.barHeight)
		}
		
		let dataSet = BarChartDataSet(entries: dataEntries, label: "")
		dataSet.colors = [UIColor(red: 56.0/255.0, green: 76.0/255.0, blue: 219.0/255.0, alpha: 1)]
		dataSet.drawValuesEnabled = false
		
		let chartData = BarChartData(dataSet: dataSet)
		chartData.barWidth = 0.33
		
		chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: bars.map {$0.barName})
		chartView.xAxis.labelCount = bars.count
		
		chartView.data = chartData
		
		chartView.notifyDataSetChanged()
		
		chartView.animate(xAxisDuration: 0.2, yAxisDuration: 0.2, easingOption: .linear)
	}
	
	lazy var titleLabel: UILabel = {
		let l = UILabel()
		l.numberOfLines = 0
		l.translatesAutoresizingMaskIntoConstraints = false
		l.textAlignment = .center
		l.font = UIFont.systemFont(ofSize: 24, weight: .light)
		return l
	}()
	
	private lazy var chartView: BarChartView = {
		let v = BarChartView()
		v.translatesAutoresizingMaskIntoConstraints = false
		return v
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(chartView)
		view.addSubview(titleLabel)
		
		setupConstraints()
		setupGraph()
	}
	
	private func setupGraph() {
		// chart has left axis, right axis and x axis
		// also it has legend, which we don't want to show
		
		let xaxis = chartView.xAxis
		xaxis.drawGridLinesEnabled = false
		xaxis.labelPosition = .bottom
		xaxis.granularity = 1.0
		xaxis.gridColor = .clear
		xaxis.forceLabelsEnabled = true
		xaxis.drawAxisLineEnabled = true
		
		chartView.leftAxis.drawGridLinesEnabled = false
		
		chartView.rightAxis.drawGridLinesEnabled = false
		
		chartView.legend.form = Legend.Form.none
	}
	
	private func setupConstraints() {
		let offset = CGFloat(8.0)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
			titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset)
		])
		
		NSLayoutConstraint.activate([
			chartView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			chartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4),
			chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
			chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset)
		])
	}
	
}

