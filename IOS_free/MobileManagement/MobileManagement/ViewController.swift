//
//  ViewController.swift
//  MobileManagement
//
//  Created by Nguyen Nam on 6/23/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var myTable: UITableView!
    
    var mobiles:[Mobile]!
    
    var mobile:Mobile!
    var mobileBL:MobileBL = MobileBL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAdd.layer.cornerRadius = 5
        btnAdd.layer.borderWidth = 2
        btnAdd.layer.borderColor = UIColor.cyan.cgColor
        myTable.dataSource = self
        mobiles = mobileBL.getAll();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if mobile != nil{
            if mobileBL.addMobile(newMobile: mobile){
                print("Added")
                print(mobileBL.getAll().count)
                mobiles = mobileBL.getAll()
                myTable.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mobiles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("table cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL")! as! RowTableViewCell
        cell.lblMobileID.text! = mobiles[indexPath.row].mID
        cell.lblModel.text! = mobiles[indexPath.row].model
        cell.lblManufacture.text! = mobiles[indexPath.row].manufacture
        cell.lblPrice.text! = String(mobiles[indexPath.row].price)
        cell.lblAmount.text! = String(mobiles[indexPath.row].amount)
        return cell
    }
    
    @IBAction func addMobile(_ sender: Any) {
        let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addScene = sb.instantiateViewController(withIdentifier: "AddScene")
        self.navigationController?.pushViewController(addScene, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

