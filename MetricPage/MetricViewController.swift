import UIKit
import ScrollableGraphView

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
    
    var currentCellTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        initGraphView()
        initActions()
    }
    
    func initData() {
        metrics = metricDataRepository.getMetrics()
        sections = metricDataRepository.getSections()
    }
    
    func initGraphView() {
        let graphView = ScrollableGraphView()
        let linePlot = LinePlot(identifier: "line")
        let referenceLines = ReferenceLines()
        let red = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1)
        
        graphView.addPlot(plot: linePlot)
        graphView.addReferenceLines(referenceLines: referenceLines)
        graphView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        containerView.backgroundColor = red
        containerView.addSubview(graphView)
        containerView.bringSubviewToFront(graphView)
    }
    
    func initActions() {
        let valueLabelTap = UITapGestureRecognizer(target: self, action: #selector(onCurrentValueClicked))
        currentValueLabel.isUserInteractionEnabled = true
        currentValueLabel.addGestureRecognizer(valueLabelTap)
    }
    
    @objc func onCurrentValueClicked(sender: UIButton) {
        presentValueAlert()
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

extension MetricViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metrics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let metric = metrics[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MetricCell") as! MetricCell
        
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
}

extension MetricViewController: ScrollableGraphViewDataSource {
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        print("log for plot")
        switch(plot.identifier) {
        case "line":
            return MetricDataRepository.allValues[pointIndex]
        default:
            return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        print("log label")
        return "FEB \(pointIndex)"
    }
    
    func numberOfPoints() -> Int {
        print("log points")
        return MetricDataRepository.allValues.count
    }
}
