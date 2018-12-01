//
//  SettingViewController2.swift
//  MeditationTimer
//
//  Created by shogo kohraku on 2018/09/26.
//  Copyright © 2018年 shogo kohraku. All rights reserved.
//

import UIKit

class SettingViewController2: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
 {

    let effectArray : [String] = [ "OFF", "Sea", "Forest", "Cloud", "Stream" ]
    let settingKey = "effectValue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        soundEffectPicker.delegate = self
        soundEffectPicker.dataSource = self
        
        let settings = UserDefaults.standard
        let soundValue = settings.string(forKey: settingKey)
        
        for row in 0..<effectArray.count {
            if effectArray[row] == soundValue {
                soundEffectPicker.selectRow(row, inComponent: 0, animated: true)
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var soundEffectPicker: UIPickerView!
    @IBOutlet weak var chooseAction: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return effectArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(effectArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let settings = UserDefaults.standard
        settings.setValue(effectArray[row], forKey: settingKey)
        settings.synchronize()
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
