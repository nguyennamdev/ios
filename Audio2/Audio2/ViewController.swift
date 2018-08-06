//
//  ViewController.swift
//  Audio2
//
//  Created by Nguyen Nam on 12/26/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var stopButton: UIBarButtonItem!
    @IBOutlet weak var pauseButton: UIBarButtonItem!
    @IBOutlet weak var playButton: UIBarButtonItem!
    
    var timer:Timer!
    var audioPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        do{
            guard let url = Bundle.main.url(forResource: "kemduyen", withExtension: "mp3") else {
                return
            }
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            timeSlider.value = 0
            timeSlider.maximumValue = Float(audioPlayer.duration)
            currentTimeLabel.text = "\(timeSlider.value)"
            let duration:Float = Float(audioPlayer.duration)
            durationTimeLabel.text = "\(duration/60)"
        }catch let audioErr{
            print(audioErr)
        }
        
    }
    
    
    @IBAction func Play(_ sender: UIBarButtonItem) {
        audioPlayer.play()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.timeSlider.value += 1
            self.currentTimeLabel.text = "\(self.timeSlider.value)"
        })
    }
    
    @IBAction func Pause(_ sender: UIBarButtonItem) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            self.timer.invalidate()
            timer = nil
        }
    }
    
    @IBAction func Stop(_ sender: UIBarButtonItem) {
        if audioPlayer.isPlaying {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            self.timeSlider.value = 0
            self.currentTimeLabel.text = "\(self.timeSlider.value)"
            self.timer.invalidate()
            timer = nil
        }
    }
    
    
//    func convertSecondToMinute(duration:Float) -> String {
//        let minute = duration / 60
//        _ = (duration % 60)
//        return ":"
//    }
//    
}

