import UIKit

class MetricEditCell: UITableViewCell {
    
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var addOrRemoveButton: UIButton!
    
    var isAdded: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setMetricEdit() {
        addOrRemoveButton.addTarget(self, action: #selector(addOrRemoveButtonClicked), for: .touchUpInside)
    }
    
    @objc func addOrRemoveButtonClicked(_sender: UIButton) {
        addOrRemoveButton.setTitle("Remove", for: .normal)
    }
    
}
