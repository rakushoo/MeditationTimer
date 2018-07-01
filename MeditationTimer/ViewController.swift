//
//  ViewController.swift
//  MeditationTimer
//
//  Created by shogo on 2018/06/17.
//  Copyright © 2018年 shogo kohraku. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer: Timer!
    var startTime = Date()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBAction func button() {
        label.text = "瞑想中です。"
        startTimer()
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
    }
    
    func stopTimer() {
        if timer != nil{
            timer.invalidate()
        }
    }
    
    func resetTimer() {
        if timer != nil {
            minuteLabel.text = "00"
            secondLabel.text = "00"
        }
    }
   
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

