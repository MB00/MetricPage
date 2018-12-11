//
//  GraphDataFormatter.swift
//  MetricPage
//
//  Created by Nicholas Della Valle on 11/30/18.
//  Copyright © 2018 MB00. All rights reserved.
//

import Foundation


class GraphDataFormatter {
    
    fileprivate static var dateOnlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd"
        return formatter
    }()
    
    
    enum ViewRange : String {
        case week
        case month
        case sixMonth
        case year
        case all
        
        var daysInPast : Int? {
            switch self {
            case .week:
                return 7
            case .month:
                return 31
            case .sixMonth:
                return 180
            case .year:
                return 365
            case .all:
                return nil
            }
        }
        
    }
    
    var startDate : Date!
    var viewRange : ViewRange = .month
    
    var xrange : Double {
        return Double(maxX - minX)
    }
    
    var yrange : Double {
        
        return Double(maxY - minY)
    }
    
    var minX = -1

    
    var maxX : Int {
        return self.distanceFromStart(date: Date())
    }
    
    var minY : Double {
        
        let dataMin = self.points.map({return $0.1}).min() ?? 0.0
        
        return dataMin
        
    }
    
    var maxY : Double {
        
        let dataMax = self.points.map({return $0.1}).max() ?? 0.0
        
        return dataMax
    }
    
    
    var paddedMinY : Double {
        return minY - yrange*0.15
    }
    
    var paddedMaxY : Double {
        return maxY + yrange*0.15
    }
    
    
    private var points : [(Date,Double)]
    
    
    init(points : [(Date,Double)], range : ViewRange) {
        
        var components = DateComponents()
        var start : Date
        
        if range != .all {
            components.day = -range.daysInPast!
            let date = Calendar.current.date(byAdding: components, to: Date())!
            start = Calendar.current.startOfDay(for: date)
        } else if let date = points.first {
            start = date.0
        } else {
            components.day = -ViewRange.year.daysInPast!
            let date = Calendar.current.date(byAdding: components, to: Date())!
            start = Calendar.current.startOfDay(for: date)
        }
        
        self.points = points.filter({$0.0 >= start})
        self.startDate = start
        
    }
    
    
    
    func getXLabelFormatter() -> (Int,Double)-> String {
        let date = self.startDate!
        let xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
            var components = DateComponents()
            components.day = Int(labelValue)
            let date = Calendar.current.date(byAdding: components, to: date)!
            return GraphDataFormatter.dateOnlyFormatter.string(from: date)
        }
        
        return xLabelsFormatter
    }
    
    
    var yLabelsCoordinates : [Double] {
        
        let yVals =  self.plotsPoints.map({return $0.1})
        
        var yLabels : [Double] = []
        
        for (index, val) in yVals.enumerated() {
            
            if index == 0 {
                yLabels.append(val)
            } else  {
                
                let close = yLabels.filter({
                    let diff = yrange/(val - $0)
                    return (diff >= 10.0 || diff <= -10.0)
                    
                })
                
                if close.first == nil {
                    yLabels.append(val)
                }
                
                
            }
        }
        
        return yLabels
    }
    
    
    var xLabelCoordinates : [Double] {
        let xVals =  self.plotsPoints.map({return Double($0.0)})
        
        var xLabels : [Double] = []
        
        for (index, val) in xVals.enumerated() {
            if index == 0 {
                xLabels.append(val)
            } else if self.xrange/(val - xVals[index-1]) <= 10.0 {
                xLabels.append(val)
            }
        }
        
        return xLabels
    }
    

    
    var plotsPoints : [(Int,Double)] {
        
        return self.points.map({tuple in
            return (self.distanceFromStart(date: tuple.0),tuple.1)
        })
    }
    
   
    
    private func distanceFromStart(date : Date) -> Int {
        
        let calendar = Calendar.current
        
        let date1 = calendar.startOfDay(for: startDate!)
        let date2 = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
        return components.day!
        
    }
    
    
    
}
