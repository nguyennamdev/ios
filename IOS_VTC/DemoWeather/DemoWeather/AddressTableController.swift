//
//  ViewController.swift
//  DemoWeather
//
//  Created by Nguyen Nam on 8/30/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit


private let cellID = "Cell"
class AddressTableViewController: UITableViewController {
    
    var currents:[Currently] = [Currently]()
    
    private var addCurrently:AddCurrentlyViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Home"
        self.navigationItem.backBarButtonItem?.title = " "
        self.tableView.register(AddressTableViewCell.self, forCellReuseIdentifier: cellID)
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = editButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.goToAddCurrently))
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if addCurrently != nil && addCurrently?.currently != nil{
            currents.append((addCurrently?.currently!)!)
            print(currents.count)
            self.tableView.reloadData()
        }
        self.tableView.reloadData()
    }
    
    func goToAddCurrently(){
        addCurrently = AddCurrentlyViewController()
        self.navigationController?.pushViewController(addCurrently!, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? AddressTableViewCell
        cell?.summaryLabel.text = currents[indexPath.row].summary
        cell?.cityLabel.text = currents[indexPath.row].address?.city
        cell?.temperatureLabel.text = "\(Int(convertFahrenheitDegressToCelsius(degress: currents[indexPath.row].temperature!)))ºC"
        return cell!
    }
    
    func convertFahrenheitDegressToCelsius(degress:Double) -> Double{
        return (degress - 32) / 1.8
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            currents.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
   override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }
}

