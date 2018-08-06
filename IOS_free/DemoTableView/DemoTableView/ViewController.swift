//
//  ViewController.swift
//  DemoTableView
//
//  Created by Nguyen Nam on 6/22/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource{
    
    var mang:[String]!
    var mang2:[String]!
    @IBOutlet weak var myTable2: UITableView!
    @IBOutlet weak var myTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.dataSource = self
        myTable2.dataSource = self
        mang = ["Android", "IOS", "PHP", "React Native", "Unity"]
        mang2 = ["Gao", "Sua", "Duong", "Muoi"]
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section" + String(section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0{
            return mang.count
        }
        else if tableView.tag == 1{
            return mang2.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        
        if tableView.tag == 0{
            cell?.textLabel?.text = mang[indexPath.row]
            cell?.detailTextLabel?.text = "Dong " + String(indexPath.row)
        }
        else if tableView.tag == 1{
            cell?.textLabel?.text = mang2[indexPath.row]
            cell?.detailTextLabel?.text = "Dong " + String(indexPath.row)
        }
        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

