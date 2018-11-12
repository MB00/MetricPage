import Foundation
import UIKit

class MetricEditViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var metrics = [Metric]()
    var sections = [String]()
    var metricDataRepository: MetricDataRepository = MetricDataRepository.init()
    
    var filteredMetrics = [Metric]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        initUI()
    }
    
    func initData() {
        metrics = metricDataRepository.getMetrics()
        sections = metricDataRepository.getSections()
    }
    
    func initUI() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMetrics = metrics.filter({( metric: Metric) -> Bool in
            return metric.exercise.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
//    @objc func onAddOrRemoveClicked(sender: UIButton) {
//        print("add or remove clicked")
//    }
}

extension MetricEditViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension MetricEditViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredMetrics.count
        }
        return metrics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MetricEditCell", for: indexPath) as! MetricEditCell
        let metric: Metric
     
        if isFiltering() {
            metric = filteredMetrics[indexPath.row]
        } else {
            metric = metrics[indexPath.row]
        }
        let metricCellText = metric.exercise + " " + metric.unit
        cell.textLabel!.text = metricCellText
        
        cell.setMetricEdit()
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sections[section]
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return sections.count
//    }
}
