//
//  ActivityDataSource.swift
//  openrun
//
//  Created by Rich Infante on 5/23/18.
//  Copyright © 2018 Richard Infante. All rights reserved.
//

import Foundation
import UIKit

class ActivityDataSource : NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    /// Static types array
    let types : [(String, UIImage, String)] = [
        ("Running", #imageLiteral(resourceName: "baseline_directions_run_black_48pt"), "activity.run"),
        ("Walking", #imageLiteral(resourceName: "baseline_directions_walk_black_48pt"), "activity.walk"),
        ("Cycling", #imageLiteral(resourceName: "baseline_directions_bike_black_48pt"), "activity.cycle"),
        ("Hiking",  #imageLiteral(resourceName: "baseline_terrain_black_48pt"), "activity.hiking"),
        ("Driving",  #imageLiteral(resourceName: "baseline_drive_eta_black_48pt"), "activity.driving"),
        ("Generic",  #imageLiteral(resourceName: "baseline_my_location_black_48pt"), "activity.gps"),
        ("Other", #imageLiteral(resourceName: "baseline_more_horiz_black_48pt"), "activity.other")
    ]
    
    var selectedIndex = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Create a cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityCell", for: indexPath) as! ActivityCollectionViewCell
        
        // Configure the image view with the activity image.
        cell.imageView.image = types[indexPath.item].1.withRenderingMode(.alwaysTemplate)
        cell.imageView.contentMode = .scaleAspectFit
        
        if indexPath.item == selectedIndex {
            cell.imageView.tintColor = UIColor.white
            cell.backgroundColor = UIColor(grayscale: 0.2, alpha: 1)
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 5
        } else {
            cell.backgroundColor = UIColor.clear
            cell.imageView.tintColor = UIColor(grayscale: 0.6, alpha: 1)
            cell.layer.borderWidth = 0
            cell.layer.cornerRadius = 0
        }
        
        
        // Configure the label
        cell.titleLabel.text = types[indexPath.item].0
        
        if indexPath.item == selectedIndex {
            cell.titleLabel.textColor = UIColor.white
        } else {
            cell.titleLabel.textColor = UIColor(grayscale: 0.5, alpha: 1)
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
