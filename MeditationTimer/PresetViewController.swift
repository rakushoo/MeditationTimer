//
//  PresetViewController.swift
//  MeditationTimer
//
//  Created by shogo kohraku on 2018/09/24.
//  Copyright © 2018年 shogo kohraku. All rights reserved.
//

import UIKit

class PresetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var soundEffectPicker: UIPickerView!
    @IBOutlet weak var finishSoundPicker: UIPickerView!
}
