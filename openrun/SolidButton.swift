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
        
        self.backgroundColor = UIColor.gray
        self.titleLabel?.textColor = UIColor.white
        self.setTitleColor(UIColor.black, for: .normal)
        self.layer.cornerRadius = 5
    }
}
