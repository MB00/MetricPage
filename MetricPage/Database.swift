import Foundation
import Disk

// A database class used as a temporary method to save and move data between View Controllers
// Should be completely replaced by API calls

class Database {
    
    public static func addMetric() {
        
    }
    
    public static func removeMetric() {
        
    }
    
    public static func addMetricValue() {
        
    }
    
    public static func setMetricAvailability(metric: String, action: Action) {
        do {
            try Disk.save(metric, to: .caches, as: metric)
        } catch {
            
        }
        
    }
    
    public static func getMetricAvailability(metric: String) -> Action {
        if (Disk.exists(metric, in: .caches)) {
            //let act: Action = Disk.retrieve(metric, from: .caches, as: Action.self)
            //return act
        }
        return Action.add
    }
    
}
