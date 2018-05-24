//
//  Activity.swift
//  openrun
//
//  Created by Rich Infante on 5/23/18.
//  Copyright © 2018 Richard Infante. All rights reserved.
//

import Foundation
import CoreLocation

class Activity {
    var type : String = ""
    var data : [CLLocation] = []
    
    func add(data: CLLocation) {
        self.data.append(data)
    }
}
