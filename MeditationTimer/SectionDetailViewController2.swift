//
//  SectionDetailViewController2.swift
//  MeditationTimer
//
//  Created by shogo kohraku on 2019/01/27.
//  Copyright © 2019年 shogo kohraku. All rights reserved.
//

import UIKit

class SectionDetailViewController2: UIViewController
    , UIPickerViewDataSource
    , UIPickerViewDelegate
{

    @IBOutlet weak var timerPicker: UIPickerView!
    
    //選択中のセクションを取得
    func getSectionData() -> sectionData {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let index = appDelegate.currentTimerIndex
        let data = appDelegate.timerArray[index]
        let sectionIndex = data.currentSectionIndex
        return data.section[sectionIndex]
    }
    
    func setSectionData(min: Int, sec: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let index = appDelegate.currentTimerIndex
        let data = appDelegate.timerArray[index]
        let sectionIndex = data.currentSectionIndex
        appDelegate.timerArray[index].section[sectionIndex].minute = min
        appDelegate.timerArray[index].section[sectionIndex].second = sec
    }
    
    @IBAction func chooseAction(_ sender: Any) {
        let min = intMinArray[timerPicker.selectedRow(inComponent: 0)]
        let sec = intSecArray[timerPicker.selectedRow(inComponent: 1)]
        setSectionData(min: min, sec: sec)

        _ = navigationController?.popViewController(animated: true)
        
    }
    
    let intMinArray : [Int] = [0,1,2,3,4,5,6,7,8,9,10]
    let intSecArray : [Int] = [0,10,20,30,40,50]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        timerPicker.delegate = self
        timerPicker.dataSource = self
        
        let section = getSectionData()
        //minの初期値設定
        for i in 0..<intMinArray.count {
            if intMinArray[i] == section.minute {
                timerPicker.selectRow(i, inComponent: 0, animated: true)
            }
        }
        //secの初期値設定
        for i in 0..<intSecArray.count {
            if intSecArray[i] == section.second {
                timerPicker.selectRow(i, inComponent: 1, animated: true)
            }
        }

    }
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // UIPickerViewの行数、要素の全数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        var count = -1
        if (component == 0) {
            count = intMinArray.count
        }
        else {
            count = intSecArray.count
        }
        return count
    }
    
    // UIPickerViewに表示する配列
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        //let data = getSectionData()
        
        var contents = -1
        if (component == 0) {
            contents = intMinArray[row]
            //初期表示をデータからもらう。
            //

        }else {
            contents = intSecArray[row]
        }

        return String(contents)
    }

    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        // 初期値を設定
        //timerPicker.selectRow(row, inComponent: component, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
