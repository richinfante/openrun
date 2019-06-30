//
//  ProgressViewController.swift
//  openrun
//
//  Created by Rich Infante on 5/23/18.
//  Copyright © 2018 Richard Infante. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class ProgressViewController : UIViewController {
    @IBOutlet weak var timerLabel : UILabel!
    @IBOutlet weak var distanceLabel : UILabel!
    @IBOutlet weak var mileTimeLabel : UILabel!
    @IBOutlet weak var stopButton : SolidButton!
    @IBOutlet weak var pauseButton : SolidButton!
    
    var timer: Timer?
    let speechSynthesizer = AVSpeechSynthesizer()
    var lastSplit = 0.25
    
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
        
        self.stopButton.backgroundColor = UIColor(red: 1, green: 59.0 / 255.0, blue: 48.0 / 255.0, alpha: 1)
        self.stopButton.setTitleColor(UIColor.white, for: .normal)
        
        self.pauseButton.backgroundColor = UIColor(grayscale: 0.4, alpha: 1)
        self.pauseButton.setTitleColor(UIColor.white, for: .normal)
        
        LocationProvider.shared.beginRecordingActivity()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.tick), userInfo: nil, repeats: true)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            
        } catch {
            print(error)
        }
        
        let speechUtterance = AVSpeechUtterance(string: "Activity Started.")
        let voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.siri_female_en-US_compact")
        speechUtterance.voice = voice
        speechSynthesizer.speak(speechUtterance)
 
    }
    
    @objc func tick() {
        let lm = LocationProvider.shared
        
        
        
        let elapsed = Int(lm.activity?.elapsedTime ?? 0)
        
        let min = Int(floor(Double(elapsed) / 60.0))
        let sec = elapsed % 60
        let pace = lm.activity?.lastKnownPosition?.speed ?? 0 * 0.0372823
        print(elapsed, min, sec)
        self.timerLabel.text = String(format: "%d:%02ds", min, sec)
        let metric = false
        var travelledDistance : Double!
        if metric {
            travelledDistance = floor(lm.activity?.totalDistance ?? 0) / 1000
            self.distanceLabel.text = "\(floor(lm.activity?.totalDistance ?? 0) / 1000)km"
        } else {
            travelledDistance = round((floor(lm.activity?.totalDistance ?? 0) / 5280) * 1000) / 1000
            self.distanceLabel.text = "\(round((floor(lm.activity?.totalDistance ?? 0) / 5280) * 1000) / 1000)mi"
        }
        
        /*
            time           x
            -------   =  -------
            distance       1
         
        */
        
        if travelledDistance > 0 {
            let estimate = Int(pace)
            let estmin = Int(floor(Double(estimate) / 60.0))
            let estsec = estimate % 60
            self.mileTimeLabel.text = String(format: "%d:%02d pace", estmin, estsec)
            
            
            if travelledDistance > lastSplit {
                lastSplit = lastSplit + 0.25 //min
                let speechUtterance = AVSpeechUtterance(string: "Time \(min) minutes \(sec) seconds. Distance \(travelledDistance) \(metric ? "kilometers" : "miles"). Average Pace: \(estmin) minutes \(estsec) per  \(metric ? "kilometers" : "miles").")
                let voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.siri_female_en-US_compact")
                speechUtterance.voice = voice
     
                speechSynthesizer.speak(speechUtterance)
            }
        } else {
            self.mileTimeLabel.text = "0:00 pace"
        }
        
        
        self.stopButton.setTitle("\(LocationProvider.shared.activity?.data.count ?? 0) samples (STOP)", for: .normal)
        /*
        if let lkp = lm.activity?.lastKnownPosition {
            self.mileTimeLabel.font = UIFont.systemFont(ofSize: 12)
            self.mileTimeLabel.text = "lat=\(lkp.coordinate.latitude)\nlng=\(lkp.coordinate.longitude)\nalt=\(lkp.altitude)\nvacc=\(lkp.verticalAccuracy)\nhacc=\(lkp.verticalAccuracy)"
        }*/
        

            
            
         
    }
    @IBAction func stop() {
        timer?.invalidate()
        LocationProvider.shared.activity = nil
        LocationProvider.shared.stopRecordingActivity()
        self.dismiss(animated: true, completion: nil)
    }
}
