//
//  MealCollectionViewController.swift
//  DemoCollectionView
//
//  Created by Nguyen Nam on 8/14/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit



class MealCollectionViewController: UICollectionViewController {
    
    let meals:[[UIImage]]  = [[#imageLiteral(resourceName: "apple"),#imageLiteral(resourceName: "Banana"),#imageLiteral(resourceName: "avocado"),#imageLiteral(resourceName: "backgroud")], [#imageLiteral(resourceName: "cat"),#imageLiteral(resourceName: "cat2"),#imageLiteral(resourceName: "cho"),#imageLiteral(resourceName: "dog")],[#imageLiteral(resourceName: "cinema_icon"),#imageLiteral(resourceName: "crow")]]
    let sections:[String] = ["Fruits", "Animal", "icon"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return meals.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return meals[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MealCollectionViewCell
        cell.imgMeal.image = meals[indexPath.section][indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        //1
        switch kind {
        //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "MealSectionHeader",
                                                                             for: indexPath) as! CollectionReusableView
            
            headerView.lblKind.text = sections[indexPath.section]
         
            return headerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert:UIAlertController = UIAlertController(title: "Fruit", message:"\(indexPath.section) row \(indexPath.row)", preferredStyle: UIAlertControllerStyle.alert)
        let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }

   
    */
}
