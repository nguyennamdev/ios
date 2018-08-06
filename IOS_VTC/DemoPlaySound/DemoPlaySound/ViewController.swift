//
//  ViewController.swift
//  DemoPlaySound
//
//  Created by Nguyen Nam on 12/25/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController , AVAudioPlayerDelegate{
    
    var player:AVAudioPlayer!
    var timeCurrent:TimeInterval?
    
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopButton.alpha = 0
        btnStart.alpha = 1
        
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(didEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        notification.addObserver(self, selector: #selector(didEnterForeground), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    
    @objc private func didEnterForeground(_ notification:Notification){
        if notification.name == NSNotification.Name.UIApplicationDidBecomeActive && timeCurrent != nil{
//            print(timeCurrent?.description)
            guard let currentTime = timeCurrent else {
                return
            }
            print("current time when did become active : \(currentTime)")
            playAudio(currentTime: currentTime)
        }
    }
    
    @objc private func didEnterBackground(_ notification:Notification){
        if notification.name == NSNotification.Name.UIApplicationDidEnterBackground {
            player.stop()
            print(" current time when did enter background \(player.currentTime)")
            timeCurrent = player.currentTime
            print("time current :\(String(describing: timeCurrent?.description))")
        }
    }
    
    @IBAction func startPlayAudio(_ sender: Any) {
        playAudio(currentTime: 0)
        if player.isPlaying {
            stopButton.alpha = 1
            btnStart.alpha = 0
        }
        
        print("duration \(player.duration.description)")
    }
    
    @IBAction func stopPlayAudio(_ sender: UIButton) {
        player.stop()
        if !player.isPlaying{
            btnStart.alpha = 1
            stopButton.alpha = 0
        }
        lblTimer.text = ""
    }
    
    private func playAudio(currentTime:TimeInterval){
        do{
            guard let bundle = Bundle.main.url(forResource: "kemduyen", withExtension: "mp3") else{
                return
            }
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: bundle)
            guard let player = player else {
                return
            }
            player.prepareToPlay()
            player.currentTime = currentTime
            player.play()
        }catch let err{
            print(err)
        }
    }
    
    
}

