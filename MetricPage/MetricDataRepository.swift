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
    
    static var benchPressTitle = "Bench Press"
    static var chestTitle = "Chest"
    static var deadliftTitle = "Deadlift"
    static var hipsButtTitle = "Hips/Butt"
    static var legPressTitle = "Leg Press"
    static var militaryPressTitle = "Military Press"
    static var pushupTestTitle = "Push-up Test"
    static var squatTitle = "Squat"
    static var upperArmTitle = "Upper Arm"
    static var upperThighTitle = "Upper Thigh"
    static var waistTitle = "Waist"
    
    var unitInches = "inches"
    var unitLbs = "lbs"
    
    var typeBodyMeasurements = "Body Measurements"
    var typeMaximumStrength = "Maximum Strength"
    
    init() {
        initMetrics()
        initSections()
    }
    
    func initMetrics() {
        let benchPress = Metric(exercise: MetricDataRepository.benchPressTitle, unit: unitLbs, type: typeMaximumStrength)
        let chest = Metric(exercise: MetricDataRepository.chestTitle, unit: unitInches, type: typeBodyMeasurements)
        let deadlift = Metric(exercise: MetricDataRepository.deadliftTitle, unit: unitLbs, type: typeMaximumStrength)
        let hipsButt = Metric(exercise: MetricDataRepository.hipsButtTitle, unit: unitInches, type: typeBodyMeasurements)
        let legPress = Metric(exercise: MetricDataRepository.legPressTitle, unit: unitLbs, type: typeMaximumStrength)
        let militaryPress = Metric(exercise: MetricDataRepository.militaryPressTitle, unit: unitLbs, type: typeMaximumStrength)
        let pushupTest = Metric(exercise: MetricDataRepository.pushupTestTitle, unit: unitLbs, type: typeMaximumStrength)
        let squat = Metric(exercise: MetricDataRepository.squatTitle, unit: unitLbs, type: typeMaximumStrength)
        let upperArm = Metric(exercise: MetricDataRepository.upperArmTitle, unit: unitInches, type: typeBodyMeasurements)
        let upperThigh = Metric(exercise: MetricDataRepository.upperThighTitle, unit: unitInches, type: typeBodyMeasurements)
        let waist = Metric(exercise: MetricDataRepository.waistTitle, unit: unitInches, type: typeBodyMeasurements)
        
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
        sections.append(typeBodyMeasurements)
        sections.append(typeMaximumStrength)
    }
    
    func getMetrics() -> [Metric] {
        return metrics
    }
    
    func getSections() -> [String] {
        return sections
    }
    
    struct ValueData {
        static var benchPressData = MetricData(currentValue: "+", previousValue: "N/A", averageValue: "N/A")
        static var chestData = MetricData(currentValue: "+", previousValue: "N/A", averageValue: "N/A")
        static var deadliftData = MetricData(currentValue: "+", previousValue: "N/A", averageValue: "N/A")
        static var hipsButtData = MetricData(currentValue: "+", previousValue: "N/A", averageValue: "N/A")
        static var legPressData = MetricData(currentValue: "+", previousValue: "N/A", averageValue: "N/A")
        static var militaryPressData = MetricData(currentValue: "+", previousValue: "N/A", averageValue: "N/A")
        static var pushupTestData = MetricData(currentValue: "+", previousValue: "N/A", averageValue: "N/A")
        static var squatData = MetricData(currentValue: "+", previousValue: "N/A", averageValue: "N/A")
        static var upperArmData = MetricData(currentValue: "+", previousValue: "N/A", averageValue: "N/A")
        static var upperThighData = MetricData(currentValue: "+", previousValue: "N/A", averageValue: "N/A")
        static var waistData = MetricData(currentValue: "+", previousValue: "N/A", averageValue: "N/A")
    }
    
    static func setData(selectedMetricTitle: String, currentValue: String) {
        switch selectedMetricTitle {
        case benchPressTitle:
            ValueData.benchPressData.updateAllValues(enteredValue: currentValue)
        case chestTitle:
            ValueData.chestData.updateAllValues(enteredValue: currentValue)
        case deadliftTitle:
            ValueData.deadliftData.updateAllValues(enteredValue: currentValue)
        case hipsButtTitle:
            ValueData.hipsButtData.updateAllValues(enteredValue: currentValue)
        case legPressTitle:
            ValueData.legPressData.updateAllValues(enteredValue: currentValue)
        case militaryPressTitle:
            ValueData.militaryPressData.updateAllValues(enteredValue: currentValue)
        case pushupTestTitle:
            ValueData.pushupTestData.updateAllValues(enteredValue: currentValue)
        case squatTitle:
            ValueData.squatData.updateAllValues(enteredValue: currentValue)
        case upperArmTitle:
            ValueData.upperArmData.updateAllValues(enteredValue: currentValue)
        case upperThighTitle:
            ValueData.upperThighData.updateAllValues(enteredValue: currentValue)
        case waistTitle:
            ValueData.waistData.updateAllValues(enteredValue: currentValue)
        default:
            ValueData.init()
        }
    }
    
    static func getData(selectedMetricTitle: String) -> MetricData {
        switch selectedMetricTitle {
        case benchPressTitle:
            return ValueData.benchPressData
        case chestTitle:
            return ValueData.chestData
        case deadliftTitle:
            return ValueData.deadliftData
        case hipsButtTitle:
            return ValueData.hipsButtData
        case legPressTitle:
            return ValueData.legPressData
        case militaryPressTitle:
            return ValueData.militaryPressData
        case pushupTestTitle:
            return ValueData.pushupTestData
        case squatTitle:
            return ValueData.squatData
        case upperArmTitle:
            return ValueData.upperArmData
        case upperThighTitle:
            return ValueData.upperThighData
        case waistTitle:
            return ValueData.waistData
        default:
            return MetricData(currentValue: "0", previousValue: "0", averageValue: "0")
        }
    }
    
}
