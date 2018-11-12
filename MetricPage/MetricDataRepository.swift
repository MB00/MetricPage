import Foundation

// Temporary data class that dispenses exercise values
// These values should eventually be grabbed from the API

class MetricDataRepository {
    
    static var isBenchPressAdded = false
    static var isChestAdded = false
    static var isDeadliftAdded = false
    static var isHipsButtAdded = false
    static var isLegPressAdded = false
    static var isMilitaryPressAdded = false
    static var isPushupTest = false
    static var isSquatAdded = false
    static var isUpperArmAdded = false
    static var isUpperThighAdded = false
    static var isWaistAdded = false
    
    static var benchPressDate = "Today"
    static var chestDate = "Today"
    static var deadliftDate = "Today"
    static var hipsButtDate = "Today"
    static var legPressDate = "Today"
    static var militaryPressDate = "Today"
    static var pushupTestDate = "Today"
    static var squatDate = "Today"
    static var upperArmDate = "Today"
    static var upperThighDate = "Today"
    static var waistDate = "Today"
    
    static var allValues = [Double]()
    
    static var previousValue = "N/A"
    static var valueSum = 0.0
    static var averageValue = ""
    
    var metrics: [Metric] = []
    var sections: [String] = []
    
    var unitInches = "inches"
    var unitLbs = "lbs"
    
    var typeBodyMeasurements = "Body Measurements"
    var typeMaximumStrength = "Maximum Strength"
    
    static func updateAllValues(enteredValue: String) {
        allValues.append(Double(enteredValue) ?? 0)
        previousValue = enteredValue
        valueSum += Double(enteredValue) ?? 0
        averageValue = String(valueSum / Double(allValues.count))
    }
    
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
