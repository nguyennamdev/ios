//
//  ViewController.swift
//  DemoSaveDataWithSQL
//
//  Created by Nguyen Nam on 12/26/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController {

    // MARK : Properties
    
    var foods:[Food]?
    var foodViewController:FoodViewController?
    var database = SQliteManager.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        foods = database.fetchFood()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.foodViewController != nil{
            foods = database.fetchFood()
            tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodTableViewCell
        cell.food = foods?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods!.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier ?? "") {
        case "addFoodSegue":
            self.foodViewController = segue.destination as? FoodViewController
        default:
            print("don't have any segue")
            break
        }
    }
    
    


}

