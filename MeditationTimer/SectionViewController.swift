//
//  SectionViewController.swift
//  MeditationTimer
//
//  Created by shogo kohraku on 2019/01/19.
//  Copyright © 2019年 shogo kohraku. All rights reserved.
//

import UIKit

class SectionViewController: UIViewController
    , UITableViewDataSource
    , UITableViewDelegate
{
    @IBOutlet weak var sectionTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //選択中のタイマーを取得
    func getTimerData() -> timerData {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let index = appDelegate.currentTimerIndex
        return appDelegate.timerArray[index]
    }
    
    //表示行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let data = getTimerData()
        let sectionRow = data.sectionNum
        var validRow: Int = 0
        for i in 0..<sectionRow {
            if (data.section[i].bEnabled) {
                validRow += 1
            }
        }
        return validRow
    }
    
    //セルの表示内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath)
        
        let data = getTimerData()
        //let sectionRow = data.sectionNum
        //for i in 0..<sectionRow

        let i = indexPath.row
        if (data.section[i].bEnabled) {
            //cell.textLabel!.text = data.section[i].sectionName
            cell.textLabel!.text =
                String(format: "%@ - %d:%02d"
                    , data.section[i].sectionName
                    , data.section[i].minute
                    , data.section[i].second)
        }

        // セルに">"を表示
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    // Cell が選択された場合の定義
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        //セクション番号を取得してSection詳細Viewを開く
        let sectionIndex = indexPath.row
        
        if sectionIndex != -1 {
            // 選択したインデックスを設定
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.timerArray[appDelegate.currentTimerIndex].currentSectionIndex = sectionIndex
            //appDelegate.saveData()//このタイミングでuserDefaultsに保存
            
            // SectionDetailViewController へ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "openDetail",sender: nil)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sectionTable.reloadData()
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
