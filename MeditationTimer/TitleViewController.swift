//
//  TitleViewController.swift
//  MeditationTimer
//
//  Created by shogo kohraku on 2018/09/25.
//  Copyright © 2018年 shogo kohraku. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {

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

    @IBAction func settingClickedAction(_ sender: Any) {
        performSegue(withIdentifier: "openSetting2", sender: nil)
    }
    
    
    
    
    @IBAction func titleClickedAction(_ sender: Any) {
        performSegue(withIdentifier: "openMain", sender: nil)
    }
}
