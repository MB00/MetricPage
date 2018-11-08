import Foundation

class Metric {
    
    var exercise: String
    var unit: String
    var type: String
    
    init(exercise: String, unit: String, type: String) {
        self.exercise = exercise
        self.unit = "(" + unit + ")"
        self.type = type
    }
    
}
