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
        self.tabBar.barStyle = UITheme.current.barStyle
        self.tabBar.isTranslucent = UITheme.current.barTranslucent
    }
}

class OpenRunNavigationController : UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform base style changes.
        self.navigationBar.barStyle = UITheme.current.barStyle
        self.navigationBar.isTranslucent = UITheme.current.barTranslucent

    }
}
