//
//  ViewController.swift
//  DemoTableViewImage
//
//  Created by Nguyen Nam on 6/22/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    

    @IBOutlet weak var myTable: UITableView!
    var mang:[String] = ["cho", "hinh", "meo"]
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.dataSource = self
        myTable.delegate = self
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let manhinh2 = sb.instantiateViewController(withIdentifier: "MANHINH2") as! ManHinh2ViewController
        manhinh2.tenHinh = mang[indexPath.row]
        self.navigationController?.pushViewController(manhinh2, animated: true)
    }
    
    
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mang.count
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as! DongTableViewCell
        cell.imgHinh.image = UIImage(named: String(mang[indexPath.row]))
        cell.lblName.text! = mang[indexPath.row]
        return cell
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

