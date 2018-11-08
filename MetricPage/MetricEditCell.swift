import UIKit

class MetricEditCell: UITableViewCell {
    
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var addOrRemoveButton: UIButton!
    
    var isAdded: Bool = false
    
    func setMetricEdit(metric: Metric) {
        exerciseLabel.text = metric.exercise
        unitLabel.text = metric.unit
        
        addOrRemoveButton.addTarget(self, action: #selector(addOrRemoveButtonClicked), for: .touchUpInside)
    }
    
    @objc func addOrRemoveButtonClicked(_sender: UIButton) {
        if (isAdded) {
            print("is added")
            addOrRemoveButton.setTitle("Remove", for: .normal)
            isAdded = false
        } else {
            print("is NOT added")
            addOrRemoveButton.setTitle("Add", for: .normal)
            isAdded = true
        }
    }
    
}
