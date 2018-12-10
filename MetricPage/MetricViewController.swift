import UIKit
import SwiftChart
//import ScrollableGraphView

class MetricViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var previousValueLabel: UILabel!
    @IBOutlet weak var averageValueLabel: UILabel!
    
    @IBOutlet weak var field: UITextField!
    
    var metrics: [Metric] = []
    var sections: [String] = []
    var metricDataRepository: MetricDataRepository = MetricDataRepository.init()
    
    let footerHeight : CGFloat = 50
    let headerHeight : CGFloat = 30
    
    var currentCellTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.showsVerticalScrollIndicator = false
        
        initData()
        initGraphView()
        initActions()
        
        
    }
    
    func initData() {
        metrics = metricDataRepository.getMetrics()
        sections = metricDataRepository.getSections()
    }
    
    func initGraphView() {
        let graphView = Chart()
        graphView.delegate = self

    
        let formatter = GraphDataFormatter(points: getFakeGraphData(), range: .month)
        
        graphView.minX = -2
        graphView.maxX = Double(formatter.maxX)
        graphView.minY = formatter.paddedMinY
        graphView.maxY = formatter.paddedMaxY
        
        
        let series = ChartSeries(data: formatter.plotsPoints)
        series.area = true
        
        graphView.xLabels = formatter.xLabelCoordinates
        graphView.yLabels = formatter.yLabelsCoordinates
        
        
        // Format the labels with a unit
        graphView.xLabelsFormatter = formatter.getXLabelFormatter()
        graphView.showYLabelsAndGrid = true
        graphView.add(series)
        graphView.backgroundColor = UIColor.white
        graphView.frame = containerView.bounds
        
        containerView.addSubview(graphView)
        containerView.bringSubviewToFront(graphView)
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: footerHeight)
        button.addTarget(self, action: #selector(addMetricsPressed), for: .touchUpInside)
        button.setTitle("+ Add More Metrics", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        self.tableView.tableFooterView = button
    }
    
    private func getFakeGraphData() -> [(Date,Double)] {
        var points : [(Date,Double)] = []
        
        let start = Date()
        
        var components = DateComponents()
        
        components.day = -28
        var nextdate = Calendar.current.date(byAdding: components, to: start)!
        points.append((nextdate,168.0))
        
        components.day = -26
        nextdate = Calendar.current.date(byAdding: components, to: start)!
        points.append((nextdate,166.5))
        
        components.day = -24
        nextdate = Calendar.current.date(byAdding: components, to: start)!
        points.append((nextdate,163.5))
        
        components.day = -23
        nextdate = Calendar.current.date(byAdding: components, to: start)!
        points.append((nextdate,163.8))
        
        components.day = -21
        nextdate = Calendar.current.date(byAdding: components, to: start)!
        points.append((nextdate,163.5))
        
        components.day = -20
        nextdate = Calendar.current.date(byAdding: components, to: start)!
        points.append((nextdate,162.5))
        
        components.day = -16
        nextdate = Calendar.current.date(byAdding: components, to: start)!
        points.append((nextdate,163.5))
        
        components.day = -10
        nextdate = Calendar.current.date(byAdding: components, to: start)!
        points.append((nextdate,162.0))
        
        components.day = -9
        nextdate = Calendar.current.date(byAdding: components, to: start)!
        points.append((nextdate,160.5))
        
        components.day = -7
        nextdate = Calendar.current.date(byAdding: components, to: start)!
        points.append((nextdate,160.5))
        
        components.day = -4
        nextdate = Calendar.current.date(byAdding: components, to: start)!
        points.append((nextdate,161.5))
        
        components.day = -2
        nextdate = Calendar.current.date(byAdding: components, to: start)!
        points.append((nextdate,161.2))
        
        components.day = -1
        nextdate = Calendar.current.date(byAdding: components, to: start)!
        points.append((nextdate,161.5))
        
        
        return points
    }
    
    func initActions() {
        let valueLabelTap = UITapGestureRecognizer(target: self, action: #selector(onCurrentValueClicked))
        currentValueLabel.isUserInteractionEnabled = true
        currentValueLabel.addGestureRecognizer(valueLabelTap)
    }
    
    @objc func onCurrentValueClicked(sender: UIButton) {
        presentValueAlert()
    }
    
    @objc private func addMetricsPressed() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "MetricEditViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func presentValueAlert() {
        let alert = UIAlertController(title: "Add value", message: "Enter current value", preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Value goes here"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
            if let textField = alert.textFields?.first {
                if textField.text == "" {
                    print("alert text empty")
                } else {
                    print("alert text not empty")
                }
            }
            MetricDataRepository.setData(selectedMetricTitle: self.currentCellTitle, currentValue: (alert.textFields?.first?.text)!)
            self.loadValuesForSelectedMetric(selectedMetricTitle: self.currentCellTitle)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadValuesForSelectedMetric(selectedMetricTitle: String) {
        let data: MetricData = MetricDataRepository.getData(selectedMetricTitle: selectedMetricTitle)
        currentValueLabel.text = String(data.currentValue)
        previousValueLabel.text = String(data.previousValue)
        averageValueLabel.text = String(data.averageValue)
    }
    
}

extension MetricViewController : ChartDelegate {
    func didTouchChart(_ chart: Chart, indexes: [Int?], x: Double, left: CGFloat) {
        print("touch")
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
    
}

extension MetricViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metrics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let metric = metrics[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MetricCell") as! MetricCell
        cell.selectionStyle = .none
        
        cell.setMetric(metric: metric)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let metric = metrics[indexPath.row]
        currentCellTitle = metric.exercise
        
        loadValuesForSelectedMetric(selectedMetricTitle: metric.exercise)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        let hview = UIView()
        hview.backgroundColor = UIColor.white
        hview.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: headerHeight)
        
        let sectionTitle = sections[section]
        label.backgroundColor = UIColor.black.withAlphaComponent(0.03)
        label.textAlignment = .center
        label.textColor = UIColor.gray
        label.text = sectionTitle
        hview.addSubview(label)
        label.frame = hview.bounds
        
        return hview
    }
    
 
}



//
//extension MetricViewController: ScrollableGraphViewDataSource {
//    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
//        print("log for plot")
//        switch(plot.identifier) {
//        case "line":
//            return MetricDataRepository.allValues[pointIndex]
//        default:
//            return 0
//        }
//    }
//
//    func label(atIndex pointIndex: Int) -> String {
//        print("log label")
//        return "FEB \(pointIndex)"
//    }
//
//    func numberOfPoints() -> Int {
//        print("log points")
//        return MetricDataRepository.allValues.count
//    }
//}
