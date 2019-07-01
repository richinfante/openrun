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
import MediaPlayer


class ProgressViewController : UIViewController {
    @IBOutlet weak var timerLabel : UILabel!
    @IBOutlet weak var distanceLabel : UILabel!
    @IBOutlet weak var mileTimeLabel : UILabel!
    @IBOutlet weak var debugLabel : UILabel!
    
    @IBOutlet weak var nowPlayingBackgound: UIView!
    @IBOutlet weak var albumArtwork: UIImageView!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var trackMeta: UILabel!
    
    @IBOutlet weak var playButton : UIButton!
    @IBOutlet weak var nextButton : UIButton!
    @IBOutlet weak var previousButton : UIButton!
    @IBOutlet weak var progressBar : UIProgressView!
    
    @IBOutlet weak var stopButton : SolidButton!
    @IBOutlet weak var pauseButton : SolidButton!
    
    var timer: Timer?
    let speechSynthesizer = AVSpeechSynthesizer()
    var lastSplit = 0.25
    var enableInvertedUnits = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func playPause() {
        if MPMusicPlayerController.systemMusicPlayer.playbackState == .playing {
            MPMusicPlayerController.systemMusicPlayer.pause()
        } else {
            MPMusicPlayerController.systemMusicPlayer.play()
        }
        self.updateNowPlaying()
    }
    
    @IBAction func nextSong() {
        MPMusicPlayerController.systemMusicPlayer.skipToNextItem()
        self.updateNowPlaying()
    }
    
    @IBAction func previousSong() {
        if MPMusicPlayerController.systemMusicPlayer.currentPlaybackTime < 2 {
            MPMusicPlayerController.systemMusicPlayer.skipToPreviousItem()
        } else {
            MPMusicPlayerController.systemMusicPlayer.skipToBeginning()
        }

        self.updateNowPlaying()
    }
    
    var recognizer : UITapGestureRecognizer?
    var unitToggleRecognizer : UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Progress"
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.toggleDebug))
        recognizer.numberOfTapsRequired = 5
        self.timerLabel.addGestureRecognizer(recognizer)
        self.timerLabel.isUserInteractionEnabled = true
        self.recognizer = recognizer
        
        let unitToggleRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.toggleInvertedUnits))
        unitToggleRecognizer.numberOfTapsRequired = 1
        self.mileTimeLabel.addGestureRecognizer(unitToggleRecognizer)
        self.mileTimeLabel.isUserInteractionEnabled = true
        self.unitToggleRecognizer = unitToggleRecognizer
        
        
        self.timerLabel.textColor = UIColor.white
        self.distanceLabel.textColor = UIColor.white
        self.mileTimeLabel.textColor = UIColor.white
        self.debugLabel.textColor = UIColor.white
        self.trackTitle.textColor = UIColor.white
        self.trackMeta.textColor = UIColor.lightGray
        self.nowPlayingBackgound.layer.cornerRadius = 5
        self.albumArtwork.backgroundColor = UIColor.clear
        self.albumArtwork.layer.cornerRadius = 5
        self.albumArtwork.layer.masksToBounds = true
        self.nowPlayingBackgound.backgroundColor = UIColor.darkGray
        self.playButton.tintColor = UIColor.white
        self.nextButton.tintColor = UIColor.white
        self.previousButton.tintColor = UIColor.white
        self.debugLabel.isHidden = true
        self.progressBar.trackTintColor = UIColor.clear
        self.progressBar.progressTintColor = UIColor.white

//        self.nowPlayingBackgound.layer.borderColor = UIColor.gray.cgColor
//        self.nowPlayingBackgound.layer.borderWidth = 1
        
        self.view.backgroundColor = UIColor(grayscale: 0.15, alpha: 1)
        
        self.stopButton.backgroundColor = UIColor(red: 1, green: 59.0 / 255.0, blue: 48.0 / 255.0, alpha: 1)
        self.stopButton.setTitleColor(UIColor.white, for: .normal)
        
        self.pauseButton.backgroundColor = UIColor(grayscale: 0.4, alpha: 1)
        self.pauseButton.setTitleColor(UIColor.white, for: .normal)
        
        self.updateNowPlaying()

        LocationProvider.shared.beginRecordingActivity()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.tick), userInfo: nil, repeats: true)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            
        } catch {
            print(error)
        }
        
        speechSynthesizer.delegate = self

        let speechUtterance = AVSpeechUtterance(string: "Activity Started.")
        let voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.siri_female_en-US_compact")
        speechUtterance.voice = voice
        
        speechSynthesizer.speak(speechUtterance)
        
 
    }
    
    @objc func toggleDebug() {
        self.debugLabel.isHidden = !self.debugLabel.isHidden
    }
    
    @objc func toggleInvertedUnits () {
        self.enableInvertedUnits = !self.enableInvertedUnits
        self.tick()
    }
    
    func updateNowPlaying() {
        if let item = MPMusicPlayerController.systemMusicPlayer.nowPlayingItem {
            self.nowPlayingBackgound.isHidden = false
            if MPMusicPlayerController.systemMusicPlayer.playbackState == .playing {
                self.playButton.imageView?.image = #imageLiteral(resourceName: "baseline_pause_black_48pt")
            } else {
                self.playButton.imageView?.image = #imageLiteral(resourceName: "baseline_play_arrow_black_48pt")
            }
            
            self.albumArtwork.image = item.artwork?.image(at: self.albumArtwork.frame.size)
            self.trackTitle.text = item.title
            self.trackMeta.text = "\(item.artist ?? "") • \(item.albumTitle ?? "")"
            self.progressBar.progress = Float(MPMusicPlayerController.systemMusicPlayer.currentPlaybackTime / item.playbackDuration)
        } else {
            self.nowPlayingBackgound.isHidden = true
        }
    }
    
    @objc func tick() {
        let lm = LocationProvider.shared
        
        updateNowPlaying()
//        print(MPMusicPlayerController.systemMusicPlayer.nowPlayingItem?.title)
//        MPMusicPlayerController.systemMusicPlayer.nowPlayingItem?.artwork?.image(at: self.bounds.size)
        
        
        if let coordinate = lm.location?.location {
            self.debugLabel.text = "Samples: \(LocationProvider.shared.activity?.data.count ?? 0)\nLat:\(coordinate.coordinate.latitude),\nLng:\(coordinate.coordinate.longitude),\nAlt:\(coordinate.altitude)"
        } else {
            self.debugLabel.text = "Location Unknown"
        }
        let elapsed = Int(lm.activity?.elapsedTime ?? 0)
        
        let min = Int(floor(Double(elapsed) / 60.0))
        let sec = elapsed % 60
//        let
        let pace : Double
        
        if enableInvertedUnits {
            pace = lm.activity?.lastKnownPosition?.speed ?? 0 * 2.23694
        } else {
            pace = lm.activity?.lastKnownPosition?.speed ?? 0 * 26.8224 // magic: 26.8224 = conversion factor (m/s -> min/mi)
        }
        
        print(elapsed, min, sec)
        self.timerLabel.text = String(format: "%d:%02ds", min, sec)
        let metric = false
        var travelledDistance : Double!

        if metric {
            travelledDistance = floor(lm.activity?.totalDistance ?? 0) / 1000.0
            self.distanceLabel.text = "\(floor(lm.activity?.totalDistance ?? 0) / 1000.0)km"
        } else {
            travelledDistance = round((floor(lm.activity?.totalDistance ?? 0) / 5280.0) * 1000.0) / 1000.0
            let td = floor(lm.activity?.totalDistance ?? 0)
            self.distanceLabel.text = String(format: "%.2fmi", (td / 5280.0)) // \(round((td / 5280.0) * 1000.0) / 1000.0)mi"
        }
        
        if travelledDistance > 0 {
            let estimate = Int(pace)
            let estmin = Int(floor(Double(estimate) / 60.0))
            let estsec = estimate % 60

            if self.enableInvertedUnits {
                self.mileTimeLabel.text = String(format: "%.1f mph", pace)
            } else {
                if pace > 0 {
                    self.mileTimeLabel.text = String(format: "%d:%02d min/mi", estmin, estsec)
                } else {
                    self.mileTimeLabel.text = "0:00 min/mi"
                }
            }
            
            
            if travelledDistance > lastSplit {
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, options: .duckOthers)
                    try AVAudioSession.sharedInstance().setActive(true)
                    
                } catch {
                    print(error)
                }

                lastSplit = lastSplit + 0.25 //min
                let speechUtterance = AVSpeechUtterance(string: "Time \(min) minutes \(sec) seconds. Distance \(travelledDistance ?? 0) \(metric ? "kilometers" : "miles"). Average Pace: \(estmin) minutes \(estsec) per  \(metric ? "kilometers" : "miles").")
                let voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.siri_female_en-US_compact")
                speechUtterance.voice = voice
     
                speechSynthesizer.speak(speechUtterance)
            }
        } else {
            self.mileTimeLabel.text = "0:00 pace"
        }
    }

    @IBAction func stop() {
        timer?.invalidate()
        LocationProvider.shared.activity = nil
        LocationProvider.shared.stopRecordingActivity()
        self.dismiss(animated: true, completion: nil)
    }
}

extension ProgressViewController : AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print(error)
        }
    }
}
