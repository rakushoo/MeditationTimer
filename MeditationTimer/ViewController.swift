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
    var bRunning: Bool = true   //ロード時にfalseに切り替える.タイマー実行中か否かのフラグ
    
    //var startTime = Date()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelSectionName: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    
    /**
     * タイマー実行中、停止中の切り替え(見た目のテキストのみ)
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
            labelSectionName.text = ""
            modeLabel.text = getCurrentTimer().patternName
            buttonLabel.text = "スタート"
        }
    }
    
    /**
     * 実行するタイマーの切り替えと初期化
     */
    func selectTimer(_ bNext:Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var index = getCurrentTimerIndex()
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
        //TimerIndexを変更
        setCurrentTimerIndex(index: index)
        resetTimer()
    }
    
    /**
     * タイマーの表示を初期状態にする
     * タイマーカウントを初期化する
     */
    func initSection() {
        let minute = getCurrentSection().minute
        let second = getCurrentSection().second

        minuteLabel.text = String(format: "%02d", minute)
        secondLabel.text = String(format: "%02d", second)
        let totalSec = minute * 60 + second
        
        let settings = UserDefaults.standard
        settings.setValue(totalSec, forKey: settingKey)
        
        duration = 0
    }
    
    /**
    * 次のセクションに進む. 次のセクションが無ければfalseを返す
    */
    func nextSection() ->(Bool) {
        var bNext = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tIndex = appDelegate.currentTimerIndex
        let sIndex = appDelegate.timerArray[tIndex].currentSectionIndex
        let nextIndex = sIndex + 1
        if ((nextIndex < appDelegate.timerArray[tIndex].sectionNum) &&
            (appDelegate.timerArray[tIndex].section[nextIndex].bEnabled))
        {
            appDelegate.timerArray[tIndex].currentSectionIndex = nextIndex
            bNext = true
        }
        return bNext
    }
    
    func getCurrentTimerIndex() -> (Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.currentTimerIndex
    }
    func setCurrentTimerIndex(index: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.currentTimerIndex = index
        setCurrentSectionIndex(index: 0) //SectionIndexも初期化する
    }
    func getCurrentTimer() -> (timerData) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let index = getCurrentTimerIndex()
        return appDelegate.timerArray[index]
    }
    func getCurrentSectionIndex() -> (Int) {
        return getCurrentTimer().currentSectionIndex
    }
    func setCurrentSectionIndex(index: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tIndex = getCurrentTimerIndex()
        appDelegate.timerArray[tIndex].currentSectionIndex = index
    }
    func getCurrentSection() -> (sectionData) {
        let sIndex = getCurrentSectionIndex()
        return getCurrentTimer().section[sIndex]
    }
    
    
    /*
    *  start/stopボタン押下時の処理
    */
    @IBAction func startButtonPushed() {
        changeState()
        
        if (!bRunning) {//停止時の処理
            stopTimer()
            return
        }
        startTimer()
        return
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

        // 現在指定されているセクション状態を初期化
        initSection()
    }
   
    func startTimer() {
        //タイマー開始・再開時の処理
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                //タイマー実行中なら何もしない
                return
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerCount(_:)), userInfo: nil, repeats: true)
            /*
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tIndex = appDelegate.currentTimerIndex
        let sIndex = appDelegate.timerArray[tIndex].currentSectionIndex
        //現在のセクション名を表示
        labelSectionName.text = appDelegate.timerArray[tIndex].section[sIndex].sectionName
*/
        labelSectionName.text = getCurrentSection().sectionName
        
        //音を鳴らす
        let id: SectionSound = getCurrentSection().sound

        var soundName: String
        switch id {
        case .Stream: soundName = "water current"
            break
        case .Sea:    soundName = "sea"
            break
        case .Forest: soundName = "forest"
            break
        case .Cloud:  soundName = "rain"
            break
        }
        playSound(name: soundName)
    }
    
    
    func stopTimer() {
        if timer != nil{
            timer.invalidate()
        }
        audioPlayer.stop()
    }
    
    func resetTimer() {
        modeLabel.text = getCurrentTimer().patternName
        //SectionIndexを初期化
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.timerArray[getCurrentTimerIndex()].currentSectionIndex = 0
        initSection()
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

    //@IBAction func presetOpenAction(_ sender: Any) {
    //    performSegue(withIdentifier: "testSegue", sender: nil)
    //}
    
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
    
    func timerCount(_ timer:Timer){
        duration += 1
        if displayUpdate() <= 0 {
            duration = 0
            //セクション終了音を鳴らす
/*            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let tIndex = appDelegate.currentTimerIndex
            let sIndex = appDelegate.timerArray[tIndex].currentSectionIndex
            let alerm = appDelegate.timerArray[tIndex].section[sIndex].alerm
*/
            let alerm = getCurrentSection().alerm
            playAlert(alerm)

            audioPlayer.stop()
            
            //次のセクションへ
            if (nextSection()) {
                stopTimer()
                startTimer()
            }
            else {
                stopTimer()
                resetTimer()
                changeState()
            }
        }
    }
    
    //システムサウンドを再生する
    func playAlert(_ id: SectionAlerm) {
        //https://qiita.com/hideji2/items/e7ed482ccffef2c0f66c
        var soundIdRing:SystemSoundID = 0
        var soundUrl:NSURL
        switch id {
        //TODO: セクション完了音を用意して切り替えられるようにする。
        case .Chime, .Marimba, .TempleBlock, .Triangle:
            soundUrl = NSURL(fileURLWithPath: "/System/Library/PrivateFrameworks/MessagesHelperKit.framework/Versions/A/PlugIns/AlertsController.bundle/Contents/Resources/Ringer.aiff")
            break
        }
        AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
        AudioServicesPlaySystemSound(soundIdRing)
    }
    

}

extension ViewController: AVAudioPlayerDelegate {
    //指定した音声ファイルを再生する。
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


