import Foundation

class MetricData {
    
    var currentValue: Double
    var previousValue: Double
    var averageValue: Double
    
    init(currentValue: Double, previousValue: Double, averageValue: Double) {
        self.currentValue = currentValue
        self.previousValue = previousValue
        self.averageValue = averageValue
    }
    
}
