//
//  ViewController.swift
//  DemoUISlider
//
//  Created by ReasonAmu on 7/25/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioPlayerDelegate {

    @IBOutlet weak var _switch: UISwitch!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var sliderTime: UISlider!

    @IBOutlet weak var lbl_TimeLeft: UILabel!
    @IBOutlet weak var lbl_TimeRight: UILabel!
    var audio = AVAudioPlayer()
    var timer = NSTimer()
    var PLAY_PAUSE = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //-- audio
        audio = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Tri Ky - Phan Manh Quynh", ofType: "mp3")!))
        self.audio.delegate = self
        audio.prepareToPlay()
        
        //-- Slider
        slider.maximumValue = 10
        slider.minimumValue = 0
        slider.maximumValueImage = UIImage(named: "maxVolume")
        slider.minimumValueImage = UIImage(named: "miniVolume")
        slider.maximumTrackTintColor  = UIColor.lightGrayColor()
        slider.minimumTrackTintColor = UIColor.blueColor()
        
        
        lbl_TimeRight.text = String(format: "%2.2f", audio.duration / 60)
        
        AddThumbImgForSilder()
        
        
       
      
        
    }
   

    func updateTimer(){
        
//        let currentTime = Int(audio.currentTime)
//        let phut = Int(currentTime / 60)
//        let giay = Int(currentTime % 60)
//        let bien:Float =  Float(phut) + (Float(giay) / 100)
//        print(bien)
        
        lbl_TimeRight.text = String(format: "-%2.2f", (audio.duration / 60) - (audio.currentTime / 60))
        self.lbl_TimeLeft.text = String(format: "%2.2f", audio.currentTime / 60)
        self.sliderTime.value = Float(audio.currentTime / audio.duration)
        
        
    }
    
    func AddThumbImgForSilder(){
        
        slider.setThumbImage( UIImage(named: "thumb"), forState: .Normal )
        
        slider.setThumbImage(UIImage(named: "thumbHightLight"), forState: .Highlighted)
    }
    

    @IBAction func btnPlay(sender: AnyObject) {
        
       timer .invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        if(PLAY_PAUSE == 0){
            
            clickButton("play")
             PLAY_PAUSE = 1
            
        }else{
        
            clickButton("pause")
            PLAY_PAUSE = 0
        }
        
     
        
    }
    
    func clickButton(bien : String){
        
        if(bien == "play"){
            audio.play()
            btnPlay.setBackgroundImage(UIImage(named: "pause"), forState: .Normal)
            
        }else if (bien == "pause"){
            btnPlay.setBackgroundImage(UIImage(named: "play"), forState: .Normal)
            audio.pause()
            
        }
        
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        
        btnPlay.setBackgroundImage(UIImage(named: "play"), forState: .Normal)
        
        if(_switch.on){
            clickButton("play")
            audio.numberOfLoops = -1
            
        }else{
            
            audio.numberOfLoops = 0
        }
    }
   
    
    
    @IBAction func btn_sliderTime(sender: UISlider) {
       
        
        audio.currentTime =  Double(sender.value) * audio.duration
        print(Double(sender.value))
        
    }
    
    
    @IBAction func sliderVolume(sender: UISlider) {
        
        audio.volume  = sender.value
    }
    
}

