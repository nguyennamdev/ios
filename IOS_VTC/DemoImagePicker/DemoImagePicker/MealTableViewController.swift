//
//  MealTableViewController.swift
//  DemoImagePicker
//
//  Created by Nguyen Nam on 8/4/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    var meals = [Meal]()
    var meal:Meal?
    @IBOutlet var tableMeal: UITableView!
   
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleMeal()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    // MARK : Action
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal2 = sourceViewController.meal {
            if let selectedIndexPath = tableMeal.indexPathForSelectedRow{
                // Update an existing meal
                meals[selectedIndexPath.row] =  meal2
                tableMeal.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
                // Add a new meal.
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal2)
                tableView.insertRows(at: [newIndexPath], with: .none)
            }
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

    private func loadSampleMeal(){
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1:Meal = Meal(name: "Banh mi + khoai tay chien", image: photo1, rating: 4) else {
            fatalError("Unable init it")
        }
        
        guard let meal2:Meal = Meal(name: "Thit bo pite", image: photo2, rating: 3) else {
            fatalError("Unable init it")
        }
        guard let meal3:Meal = Meal(name: "Chese", image: photo3, rating: 2) else {
            fatalError("Unable init it")
        }
        
        meals.append(meal1)
        meals.append(meal2)
        meals.append(meal3)
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as? MealTableViewCell
        // create a meal 
        let meal = meals[indexPath.row]
        cell?.lblMealName.text = meal.name
        cell?.imgMeal.image = meal.image
        cell?.ratingMeal.rating = meal.rating
        return cell!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "" ) {
        case "showDetailSegue":
            let showDetailVC = segue.destination as? MealViewController
            meal = meals[(tableMeal.indexPathForSelectedRow?.row)!]
            showDetailVC?.meal = meal
        default:
            break
        }
    }

    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            tableMeal.deleteRows(at: [indexPath], with: .left)
            tableMeal.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   

}
