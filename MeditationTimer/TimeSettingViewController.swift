//
//  TimeSettingViewController.swift
//  MeditationTimer
//
//  Created by shogo kohraku on 2018/12/16.
//  Copyright © 2018年 shogo kohraku. All rights reserved.
//

import UIKit

class TimeSettingViewController: UIViewController
    , UITableViewDataSource
    , UITableViewDelegate
{

    @IBOutlet weak var TableView: UITableView!
    let fruits = ["apple", "orange", "melon", "peach" ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //選択中のタイマーを返す
    func getTimerData() -> timerData {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let index = appDelegate.currentTimerIndex
        return appDelegate.timerArray[index]
    }


    //表示行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let tableRow = appDelegate.timerNum
        var validRow: Int = 0
        for i in 0..<tableRow {
            if (appDelegate.timerArray[i].bEnabled) {
                validRow += 1
            }
        }
        return validRow
        //return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tableRow = appDelegate.timerNum
        for i in 0..<tableRow {
            if (appDelegate.timerArray[i].bEnabled) {
                //今は1番目のタイマーしか表示されない。indexPathと順番が一致するものだけ表示させたい
                cell.textLabel!.text = appDelegate.timerArray[i].timerName
                break;
            }
        }

        // セルに">"を表示
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    var sectionIndex = -1
    // Cell が選択された場合
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        // [indexPath.row] から画像名を探し、UImage を設定
        //タイマー番号を取得してSectionを開く
        sectionIndex = indexPath.row

        if sectionIndex != -1 {
            // SubViewController へ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "openSection",sender: nil)
        }
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
