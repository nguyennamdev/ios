//
//  PlacesViewController.swift
//  DemoGoogleMaps
//
//  Created by Nguyen Nam on 8/19/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class PlacesViewController: UIViewController , UITableViewDataSource{
    
    var likelyPlaces:[GMSPlace]?
    var selectedPlace: GMSPlace?
    
    var listMarker:[GMSMarker]?
    var selectedMarker:GMSMarker?
    
    @IBOutlet weak var myTable: UITableView!
    
    let cellReuseIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    
        myTable.delegate = self
        myTable.dataSource = self
        myTable.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMarker!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        cell?.textLabel?.text = listMarker?[indexPath.row].title 
        return cell!
    }
    
    // Show only the first five items in the table (scrolling is disabled in IB).
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return myTable.frame.size.height/5
    }
    
    // Make table rows display at proper height if there are less than 5 items.
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == tableView.numberOfSections - 1) {
            return 1
        }
        return 0
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "unwindToMain"{
//            if let nextViewController = segue.destination as? ViewController{
//                nextViewController.selectedMarker  = selectedMarker
//            }
//        }
//    }
}
extension PlacesViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMarker = listMarker?[indexPath.row]
        let viewController = navigationController?.viewControllers[0] as! ViewController
        viewController.selectedMarker = selectedMarker
        navigationController?.popToViewController(viewController, animated: true)
    }
}
