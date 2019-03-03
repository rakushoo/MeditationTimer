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
    var bRunning: Bool = true   //ロード時にfalseに切り替える
    
    var startTime = Date()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    
    /**
     * タイマー実行中、停止中の切り替え
     */
    func changeState()
    {
        bRunning = !bRunning    //トグル的に切り替える
        if (bRunning) {
            label.text = "瞑想中です。"
            modeLabel.text = ""//タイマー実行中、タイマー名は非表示
            buttonLabel.text = "ストップ"
        }
        else{
            label.text = "スタートボタンを押す。"
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let index = appDelegate.currentTimerIndex
            modeLabel.text = appDelegate.timerArray[index].timerName
            buttonLabel.text = "スタート"
        }
    }
    
    /**
     * 実行するタイマーの切り替え
     */
    func selectTimer(_ bNext:Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var index = appDelegate.currentTimerIndex
        if (bNext) {
            index = index + 1
            if(index == appDelegate.timerNum) {
                index = 0
            }
        }
        else {
            index = index - 1
            if (index == -1) {
                index = appDelegate.timerNum - 1
            }
        }
        appDelegate.currentTimerIndex = index
        modeLabel.text = appDelegate.timerArray[index].timerName

        initTimer()
    }
    
    /**
     * タイマーの表示を初期状態にする
     * タイマーカウントを初期化する
     */
    func initTimer() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tIndex = appDelegate.currentTimerIndex
        let sIndex = appDelegate.timerArray[tIndex].currentSectionIndex
        let minute = appDelegate.timerArray[tIndex].section[sIndex].minute
        let second = appDelegate.timerArray[tIndex].section[sIndex].second
        minuteLabel.text = String(format: "%02d", minute)
        secondLabel.text = String(format: "%02d", second)
        let totalSec = minute * 60 + second
        
        let settings = UserDefaults.standard
        settings.setValue(totalSec, forKey: settingKey)
    }
    
    @IBAction func startButtonPushed() {
        changeState()
        
        if (!bRunning) {//停止時の処理
            stopTimer()
            return
        }
        
        //タイマー開始・再開時の処理
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                return
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerStop(_:)), userInfo: nil, repeats: true)
        
        //音を鳴らす //TODO 今のセクションの音を選択
        playSound(name: "water current")
    }
    
    @IBAction func rightButtonPushed(_ sender: UIButton) {
        if (bRunning) {
            return // タイマー実行中は動作不可
        }
        selectTimer(true)
    }
    
    @IBAction func leftButtonPushed(_ sender: UIButton) {
        if (bRunning) {
            return // タイマー実行中は動作不可
        }
        selectTimer(false)
    }
    
    
    @IBAction func resetButtonPushed() {
        if (bRunning) {
            return // タイマー実行中は動作不可
        }
        resetTimer()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        changeState()//初回のみ実施を想定
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        duration = 0
        _ = displayUpdate()

        // タイマー表示を初期化
        initTimer()
    }
   

    func stopTimer() {
        if timer != nil{
            timer.invalidate()
        }
        audioPlayer.stop()
    }
    
    func resetTimer() {
        if timer != nil {
            initTimer()
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
    //    performSegue(withIdentifier: "testSegue", sender: nil)
    }
    
    func displayUpdate() -> Int {
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        let remainSeconds = timerValue - duration

        let dispMin = remainSeconds / 60
        let dispSec = remainSeconds % 60

        minuteLabel.text = String(format: "%02d", dispMin)
        secondLabel.text = String(format: "%02d", dispSec)
        //secondLabel.text = "\(remainSeconds)"

        return remainSeconds
    }
    
    func timerStop(_ timer:Timer){
        duration += 1
        if displayUpdate() <= 0 {
            duration = 0
            stopTimer()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let tIndex = appDelegate.currentTimerIndex
            let sIndex = appDelegate.timerArray[tIndex].currentSectionIndex
            let alerm = appDelegate.timerArray[tIndex].section[sIndex].alerm
            
            playAlert(alerm)
//            //システムサウンドを再生する
//            //https://qiita.com/hideji2/items/e7ed482ccffef2c0f66c
//            var soundIdRing:SystemSoundID = 0
//            let soundUrl = NSURL(fileURLWithPath: "/System/Library/PrivateFrameworks/MessagesHelperKit.framework/Versions/A/PlugIns/AlertsController.bundle/Contents/Resources/Ringer.aiff")
//            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
//            AudioServicesPlaySystemSound(soundIdRing)
            
        }
    }
    
    func playAlert(_ id: SectionAlerm) {
        //システムサウンドを再生する
        //https://qiita.com/hideji2/items/e7ed482ccffef2c0f66c
        var soundIdRing:SystemSoundID = 0
        var soundUrl:NSURL
        switch id {
        case .Chime, .Marimba, .TempleBlock, .Triangle:
            soundUrl = NSURL(fileURLWithPath: "/System/Library/PrivateFrameworks/MessagesHelperKit.framework/Versions/A/PlugIns/AlertsController.bundle/Contents/Resources/Ringer.aiff")
            break
        }
        AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
        AudioServicesPlaySystemSound(soundIdRing)
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
