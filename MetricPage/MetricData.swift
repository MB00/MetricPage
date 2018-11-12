import Foundation

class MetricData {
    
    var currentValue: String
    var previousValue: String
    var averageValue: String
    
    var valueSum: Double = 0
    
    var allValues = [Double]()
    
    init(currentValue: String, previousValue: String, averageValue: String) {
        self.currentValue = currentValue
        self.previousValue = previousValue
        self.averageValue = averageValue
    }
    
    func updateAllValues(enteredValue: String) {
        currentValue = enteredValue
        
        if (allValues.count > 0) {
            previousValue = String(allValues[allValues.count - 1])
        } else {
            previousValue = "N/A"
        }
        allValues.append(Double(enteredValue) ?? 0)
        valueSum += Double(enteredValue) ?? 0
        averageValue = String(valueSum / Double(allValues.count))
    }
    
}
