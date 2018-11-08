import Foundation

// Temporary data class that dispenses exercise values
// These values should eventually be grabbed from the API

class MetricDataRepository {
    
    var metrics: [Metric] = []
    var sections: [String] = []
    
    var unitInches = "inches"
    var unitLbs = "lbs"
    
    var typeBodyMeasurements = "Body Measurements"
    var typeMaximumStrength = "Maximum Strength"
    
    init() {
        initMetrics()
        initSections()
    }
    
    func initMetrics() {
        let benchPress = Metric(exercise: "Bench Press", unit: unitLbs, type: typeMaximumStrength)
        let chest = Metric(exercise: "Chest", unit: unitInches, type: typeBodyMeasurements)
        let deadlift = Metric(exercise: "Deadlift", unit: unitLbs, type: typeMaximumStrength)
        let hipsButt = Metric(exercise: "Hips/Butt", unit: unitInches, type: typeBodyMeasurements)
        let legPress = Metric(exercise: "Leg Press", unit: unitLbs, type: typeMaximumStrength)
        let militaryPress = Metric(exercise: "Military Press", unit: unitLbs, type: typeMaximumStrength)
        let pushupTest = Metric(exercise: "Push-up Test", unit: unitLbs, type: typeMaximumStrength)
        let squat = Metric(exercise: "Squat", unit: unitLbs, type: typeMaximumStrength)
        let upperArm = Metric(exercise: "Upper Arm", unit: unitInches, type: typeBodyMeasurements)
        let upperThigh = Metric(exercise: "Upper Thigh", unit: unitInches, type: typeBodyMeasurements)
        let waist = Metric(exercise: "Waist", unit: unitInches, type: typeBodyMeasurements)
        
        metrics.append(benchPress)
        metrics.append(chest)
        metrics.append(deadlift)
        metrics.append(hipsButt)
        metrics.append(legPress)
        metrics.append(militaryPress)
        metrics.append(pushupTest)
        metrics.append(squat)
        metrics.append(upperArm)
        metrics.append(upperThigh)
        metrics.append(waist)
    }
    
    func initSections() {
        let bodyMeasurements = "Body Measurements"
        let maximumStrength = "Maximum Strength"
        
        sections.append(bodyMeasurements)
        sections.append(maximumStrength)
    }
    
    func getMetrics() -> [Metric] {
        return metrics
    }
    
    func getSections() -> [String] {
        return sections
    }
    
}
