import UIKit

class MetricEditCell: UITableViewCell {
    
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var addOrRemoveButton: UIButton!
    
    var isAdded: Bool = false
    
    func setMetricEdit() {
        
        addOrRemoveButton.addTarget(self, action: #selector(addOrRemoveButtonClicked), for: .touchUpInside)
    }
    
    @objc func addOrRemoveButtonClicked(_sender: UIButton) {
//        if (isAdded) {
//            print("is added")
//            //addOrRemoveButton.setTitle("Remove", for: .normal)
//            addOrRemoveButton.titleLabel?.text = "remove"
//            isAdded = false
//        } else {
//            print("is NOT added")
//            //addOrRemoveButton.setTitle("Add", for: .normal)
//            addOrRemoveButton.titleLabel?.text = "add"
//            isAdded = true
//        }
        
        addOrRemoveButton.titleLabel?.text = "remove"
    }
    
}
