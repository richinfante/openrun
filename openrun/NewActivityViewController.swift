//
//  NewActivityViewController.swift
//  openrun
//
//  Created by Rich Infante on 5/23/18.
//  Copyright © 2018 Richard Infante. All rights reserved.
//

import Foundation
import UIKit

class NewActivityViewController : UIViewController {
    @IBOutlet weak var collectionView : UICollectionView!
    
    let ds = ActivityDataSource()
    var lm : LocationProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(grayscale: 0.15, alpha: 1)
        self.title = "Activity"
        
        
        collectionView.dataSource = ds
        collectionView.delegate = ds
        collectionView.isOpaque = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = true
    }
    
    @IBAction func location() {
        lm = LocationProvider()
        lm?.beginRecordingActivity()
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProgressVC") as! UIViewController
        self.present(vc, animated: true, completion: nil)
    }
}
