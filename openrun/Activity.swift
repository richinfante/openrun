//
//  Activity.swift
//  openrun
//
//  Created by Rich Infante on 5/23/18.
//  Copyright © 2018 Richard Infante. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationDistance {
    var inFeet : Double {
        return self * (100 / (2.54 * 12))
    }
}

class Activity {
    var type : String = ""
    var data : [CLLocation] = []
    var startTime : Date?
    var endTime : Date?
    
    var lastKnownPosition : CLLocation? {
        return data.last
    }
    
    /// Average speed.1
    var averageSpeed : Double = 0
    
    /// Total Distance traveled for this activity.
    var totalDistance : Double = 0
    
    /// Total elapsed time
    var elapsedTime : TimeInterval {
        return abs(startTime?.timeIntervalSinceNow ?? 0)
    }
    
    /// Add a point. Re-calculate average speed.
    func add(point: CLLocation) {
        let oldCount = Double(data.count)
        averageSpeed = ((averageSpeed * oldCount) + point.speed) / (oldCount + 1)
        
        if let last = data.last {
            totalDistance += last.distance(from: point)
            print("got dist from last: \(last.distance(from: point))")
            
        }
        
        
        
        self.data.append(point)
    }
    
    func start() {
        if startTime == nil {
            startTime = Date()
        }
    }
    
    func stop() {
        if endTime == nil {
            endTime = Date()
        }
    }
}
