//
//  UIColor.swift
//  openrun
//
//  Created by Rich Infante on 5/23/18.
//  Copyright © 2018 Richard Infante. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init (grayscale: CGFloat, alpha: CGFloat) {
        self.init(red: grayscale, green: grayscale, blue: grayscale, alpha: alpha)
    }
}
