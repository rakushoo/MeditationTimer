//
//  ViewController.swift
//  MeditationTimer
//
//  Created by shogo on 2018/06/17.
//  Copyright © 2018年 shogo kohraku. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var timer: Timer!
    var duration = 0
    let settingKey = "timerValue"
    var audioPlayer: AVAudioPlayer!
    
    var startTime = Date()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBAction func startButtonPushed() {
        label.text = "瞑想中です。"
        
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                return
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerStop(_:)), userInfo: nil, repeats: true)
        
        //音を鳴らす
        playSound(name: "water current")
        
        //startTimer()
    }
    
    @IBAction func stopButtonPushed() {
        label.text = "停止しています。"
        stopTimer()
    }
    
    @IBAction func resetButtonPushed() {
        resetTimer()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let settings = UserDefaults.standard
        settings.register(defaults: [settingKey: 10])
        
        minuteLabel.text = "00"
        secondLabel.text = "00"
    }

    //override func viewDidAppear(_ animated: Bool) {
    //    super.viewDidAppear(true)
    //}
   
    func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(self.timerCounter),
            userInfo: nil,
            repeats: true)
        startTime = Date()
        //音を鳴らす
        playSound(name: "water current")
    }
    
    @objc func timerCounter() {
        // タイマー開始からのインターバル時間
        let currentTime = Date().timeIntervalSince(startTime)
        
        let minute = (Int)(fmod((currentTime/60), 60))
        let second = (Int)(fmod(currentTime, 60))
        
        let sMinute = String(format: "%02d", minute)
        let sSecond = String(format: "%02d", second)

        
        //let currentDate = Date()
        //let formatter = DateFormatter()
        //formatter.dateFormat = "mm:ss.SSS"
        //print(formatter.string(from: currentDate))

        minuteLabel.text = sMinute
        secondLabel.text = sSecond
        
        if second == 3 {

            stopTimer()

            audioPlayer.stop()
            
            //システムサウンドを再生する
            //https://qiita.com/hideji2/items/e7ed482ccffef2c0f66c
            var soundIdRing:SystemSoundID = 0
            let soundUrl = NSURL(fileURLWithPath: "/System/Library/PrivateFrameworks/MessagesHelperKit.framework/Versions/A/PlugIns/AlertsController.bundle/Contents/Resources/Ringer.aiff")
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
        }
    }
    
    func stopTimer() {
        if timer != nil{
            timer.invalidate()
        }
        audioPlayer.stop()
    }
    
    func resetTimer() {
        if timer != nil {
            minuteLabel.text = "00"
            secondLabel.text = "00"
        }
    }
   
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if timer != nil {
            timer.invalidate()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func presetOpenAction(_ sender: Any) {
        performSegue(withIdentifier: "testSegue", sender: nil)

    }
    
    func displayUpdate() -> Int {
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        let remainSeconds = timerValue - duration
        secondLabel.text = "\(remainSeconds)"
        return remainSeconds
    }
    
    func timerStop(_ timer:Timer){
        duration += 1
        if displayUpdate() <= 0 {
            duration = 0
            timer.invalidate()
            
            //システムサウンドを再生する
            //https://qiita.com/hideji2/items/e7ed482ccffef2c0f66c
            var soundIdRing:SystemSoundID = 0
            let soundUrl = NSURL(fileURLWithPath: "/System/Library/PrivateFrameworks/MessagesHelperKit.framework/Versions/A/PlugIns/AlertsController.bundle/Contents/Resources/Ringer.aiff")
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
            
        }
    }
}

extension ViewController: AVAudioPlayerDelegate {
    func playSound(name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("音源ファイルが見つかりません")
            return
        }
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            
            audioPlayer.delegate = self
            
            audioPlayer.play()
        } catch {

        }
    }
}
