import UIKit

class MetricCell: UITableViewCell {
    
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var lastPerformedLabel: UILabel!
    
    func setMetric(metric: Metric) {
        exerciseLabel.text = metric.exercise
        unitLabel.text = metric.unit
    }
    
}
