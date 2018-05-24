//
//  ProgressViewController.swift
//  openrun
//
//  Created by Rich Infante on 5/23/18.
//  Copyright © 2018 Richard Infante. All rights reserved.
//

import Foundation
import UIKit

class ProgressViewController : UIViewController {
    @IBOutlet weak var timerLabel : UILabel!
    @IBOutlet weak var distanceLabel : UILabel!
    @IBOutlet weak var mileTimeLabel : UILabel!
    @IBOutlet weak var stopButton : SolidButton!
    @IBOutlet weak var pauseButton : SolidButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Progress"
        
        self.timerLabel.textColor = UIColor.white
        self.distanceLabel.textColor = UIColor.white
        self.mileTimeLabel.textColor = UIColor.white
        self.view.backgroundColor = UIColor(grayscale: 0.15, alpha: 1)
        self.stopButton.backgroundColor = UIColor(red: 0.8, green: 0, blue: 0, alpha: 1)
        
        
        
        
    }
    
    @IBAction func stop() {
        self.dismiss(animated: true, completion: nil)
    }
}
