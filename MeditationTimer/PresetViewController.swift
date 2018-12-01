//
//  PresetViewController.swift
//  MeditationTimer
//
//  Created by shogo kohraku on 2018/09/24.
//  Copyright © 2018年 shogo kohraku. All rights reserved.
//

import UIKit
import Social

class PresetViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let valueArray : [Int] = [10,20,30,40,50,60]
    let settingKey = "timerValue"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timerPicker.delegate = self
        timerPicker.dataSource = self
        
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        
        for row in 0..<valueArray.count {
            if valueArray[row] == timerValue {
                timerPicker.selectRow(row, inComponent: 0, animated: true)
            }
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func tapTweetButton(_ sender: Any) {
        // Twitterの投稿ダイアログを作って
        var cv = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        // 文字を追加
        //ビルドエラーになる。。
        //cv.setInitialText("追加テキスト")
        // 投稿ダイアログを表示する
        //self.presentViewController(cv, animated: true, completion:nil )
    }
    @IBOutlet weak var soundEffectPicker: UIPickerView!
    @IBOutlet weak var finishSoundPicker: UIPickerView!
    
    @IBOutlet weak var timerPicker: UIPickerView!
    
    @IBAction func chooseAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return valueArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(valueArray[row])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let settings = UserDefaults.standard
        settings.setValue(valueArray[row], forKey: settingKey)
        settings.synchronize()
    }

}
