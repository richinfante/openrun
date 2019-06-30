//
//  NewActivityViewController.swift
//  openrun
//
//  Created by Rich Infante on 5/23/18.
//  Copyright © 2018 Richard Infante. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class NewActivityViewController : UIViewController {
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var mapView : MKMapView!
    
    let ds = ActivityDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationProvider.shared.startUpdatingLocation()
        
        self.view.backgroundColor = UITheme.current.backgroundColor
        self.title = "Activity"
        
        
        collectionView.dataSource = ds
        collectionView.delegate = ds
        collectionView.isOpaque = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = true
        
        if let loc = LocationProvider.shared.location.location {
            
            mapView.setCenter(loc.coordinate, animated: true)
            let reigon = MKCoordinateRegionMakeWithDistance(loc.coordinate, 25, 25)
            mapView.setRegion(reigon, animated: true)
            mapView.setUserTrackingMode(.follow, animated: true)

        }
    }
    
    @IBAction func location() {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProgressVC") as! UIViewController
        self.present(vc, animated: true, completion: nil)
    }
}
