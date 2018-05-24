//
//  OpenRunTabBarController.swift
//  openrun
//
//  Created by Rich Infante on 5/23/18.
//  Copyright © 2018 Richard Infante. All rights reserved.
//

import Foundation
import UIKit

class OpenRunTabBarController : UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Perform base style changes.
        self.tabBar.barStyle = .blackOpaque
        self.tabBar.isTranslucent = false
    }
}

class OpenRunNavigationController : UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform base style changes.
        self.navigationBar.barStyle = .blackOpaque
        self.navigationBar.isTranslucent = false

    }
}
