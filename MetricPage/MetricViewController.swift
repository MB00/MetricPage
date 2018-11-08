import UIKit
import ScrollableGraphView

class MetricViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let graphView = ScrollableGraphView()
    
    var metrics: [Metric] = []
    var sections: [String] = []
    var metricDataRepository: MetricDataRepository = MetricDataRepository.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        metrics = metricDataRepository.getMetrics()
        sections = metricDataRepository.getSections()
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
}
