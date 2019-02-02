//
//  SectionDetailViewController.swift
//  MeditationTimer
//
//  Created by shogo kohraku on 2018/09/24.
//  Copyright © 2018年 shogo kohraku. All rights reserved.
//

import UIKit
import Social

class SectionDetailViewController: UIViewController
    , UIPickerViewDataSource
    , UIPickerViewDelegate
{

    //let valueArray : [Int] = [10,20,30,40,50,60]
    //let settingKey = "timerValue"
    //var dispMinute: Int = 0
    //var dispSecond: Int = 0

    //選択中のセクションを取得
    func getSectionData() -> sectionData {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let index = appDelegate.currentTimerIndex
        let data = appDelegate.timerArray[index]
        let sectionIndex = data.currentSectionIndex
        return data.section[sectionIndex]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //timerPicker.delegate = self
        //timerPicker.dataSource = self
        
        // データ共有方法
        //let settings = UserDefaults.standard
        //let timerValue = settings.integer(forKey: settingKey)
        
        //AppDelegateのインスタンスを取得
 //       let data = getSectionData()
//        let curMinute = data.minute
        //let curSecond = data.second

        //for row in 0..<valueArray.count {
//            if dispMinute == curMinute {
//                timerPicker.selectRow(row, inComponent: 0, animated: true)
//            }
        //}

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
        //var cv = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        // 文字を追加
        //cv?.setInitialText("追加テキスト")
        // 投稿ダイアログを表示する ビルドエラーになる。。
        //self.presentViewController(cv, animated: true, completion:nil )
    }


    @IBOutlet weak var soundEffectPicker: UIPickerView!
    @IBOutlet weak var finishSoundPicker: UIPickerView!
    
    @IBOutlet weak var timerPicker: UIPickerView!
    
    @IBAction func chooseAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // 列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    // 行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60//valueArray.count
    }
    // 表示内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)//valueArray[row])
    }
    // 選択された時の動作
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //let settings = UserDefaults.standard
        //settings.setValue(valueArray[row], forKey: settingKey)
        //settings.synchronize()
    }

}
