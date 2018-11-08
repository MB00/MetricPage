import Foundation
import UIKit

class MetricEditViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var metrics: [Metric] = []
    var metricDataRepository: MetricDataRepository = MetricDataRepository.init()
    
    var searchMetric = [String]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        metrics = metricDataRepository.getMetrics()
    }
    
    var test = ["hello", "searching"]
}

extension MetricEditViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //searchMetric = metrics.filter({$0.exercise == searchText})
        if searchText == "" {
            isSearching = false
            tableView.reloadData()
        } else {
            searchMetric = test
            isSearching = true
            tableView.reloadData()
        }
    }
}

extension MetricEditViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchMetric.count
        } else {
            return metrics.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let metric = metrics[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MetricEditCell") as! MetricEditCell
        
        if isSearching {
            cell.textLabel?.text = metrics[indexPath.row].exercise
        }
        
        cell.setMetricEdit(metric: metric)
        
        return cell
    }
}
