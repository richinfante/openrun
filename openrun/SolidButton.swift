//
//  SolidButton.swift
//  openrun
//
//  Created by Rich Infante on 5/23/18.
//  Copyright © 2018 Richard Infante. All rights reserved.
//

import Foundation
import UIKit

class SolidButton : UIButton {
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.backgroundColor = UIColor(red: 76.0 / 255.0 , green: 217.0 / 255.0, blue: 100.0 / 255.0, alpha: 1)
        self.titleLabel?.textColor = UIColor.white
        self.setTitleColor(UIColor.black, for: .normal)
        self.layer.cornerRadius = 5
    }
}
