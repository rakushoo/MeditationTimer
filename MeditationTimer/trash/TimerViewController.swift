//
//  TimerViewController.swift
//  MeditationTimer
//
//  Created by shogo kohraku on 2018/12/16.
//  Copyright © 2018年 shogo kohraku. All rights reserved.
//

import UIKit

class TimerViewController: UITabBarController
//    , UITableViewDelegate
//    , UITableViewDataSource
{
    //@IBOutlet weak var TableView: UITableView!
    
    
    //let TODO = ["timer1", "timer2", "timer3", "timer4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        //TableView.delegate = self
        //TableView.dataSource = self
        //tableView2.register(UINib(nibName: "cell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    //追加③ セルの個数を指定するデリゲートメソッド（必須）
   // func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("step3")
    //    return 3//TODO.count
    //}
    
    //追加④ セルに値を設定するデータソースメソッド（必須）
    //func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
       // let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        // セルに表示する値を設定する
        //cell.textLabel!.text = "testAnalyze"//TODO[indexPath.row]
        //print("step4")
        //return cell
    //}

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
