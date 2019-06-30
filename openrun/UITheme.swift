//
//  UITheme.swift
//  openrun
//
//  Created by Rich Infante on 5/25/18.
//  Copyright © 2018 Richard Infante. All rights reserved.
//

import Foundation
import UIKit


class UITheme {
    static var `default` = UITheme()
    static var current = UITheme.default
    
    var barColor = UIColor.black
    var barStyle : UIBarStyle = .blackOpaque
    var barTint = UIColor.white
    var barTranslucent = false
    
    var backgroundColor = UIColor(grayscale: 0.15, alpha: 1)
    var accentColor = UIColor(grayscale: 0.2, alpha: 1)
    var labelColor = UIColor.white
    var mutedLabelColor = UIColor.gray
}

extension UITheme {
    static var white = UIThemeWhite()
}

class UIThemeWhite : UITheme {
    override init() {
        super.init()
        
        self.barTint = UIColor.blue
        self.barStyle = .default
        self.barColor = UIColor.white
        self.barTranslucent = false
        
        self.backgroundColor = UIColor.white
        self.accentColor = UIColor(grayscale: 0.95, alpha: 1)
        self.labelColor = UIColor(grayscale: 0.05, alpha: 1)
    }
}
