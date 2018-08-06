//
//  BookTableViewController.swift
//  DemoTableView
//
//  Created by Nguyen Nam on 8/7/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController {
    
    var bookFilter:[Book] = [Book]()
    var books:[Book] = [Book]()
    var book:Book?
    @IBOutlet var bookTableView: UITableView!
    private var aeBookVC:AddEditBookViewController?
    @IBOutlet weak var bookSearchBar: UISearchBar!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        books = [Book("Data Struct And Arth..", "I don't now", #imageLiteral(resourceName: "girl"), 20000), Book("NodeJS", "Nam", #imageLiteral(resourceName: "girl"), 10000)]
        navigationItem.leftBarButtonItem = editButtonItem
    
//      bookSearchBar.scopeButtonTitles = ["All", "Story", "Hentai", "Other"]
        searchController.searchResultsUpdater = self
        // make background dims
        searchController.dimsBackgroundDuringPresentation = true
        //
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["Title", "Author"]
        searchController.delegate = self
        searchController.searchBar.selectedScopeButtonIndex = 0
    }

    
    // MARK : Filter result search
    func filterContentForScope(searchBarScopeText:String){
        bookFilter = books.filter{ book in
            return book.author.localizedLowercase.contains(searchBarScopeText.localizedLowercase)
        }
        bookTableView.reloadData()
    }
    
    
    public func filterContentForSearchText(searchText:String){
        // filter to get  books
        bookFilter = books.filter{ book in
            return book.title.localizedLowercase.contains(searchText.localizedLowercase)
        }
        bookTableView.reloadData()
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive && searchController.searchBar.text != "" {
            return bookFilter.count
        }
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookTableViewCell") as! BookTableViewCell
        if searchController.isActive && searchController.searchBar.text != ""{
            cell.book = bookFilter[indexPath.row]
        }
        else{
            cell.book = books[indexPath.row]
        }
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // add book
        if(aeBookVC != nil && !((aeBookVC?.isEditingBook)!) && aeBookVC?.book != nil){
            books.append((aeBookVC?.book)!)
            bookTableView.reloadData()
        }
        bookTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier ?? "") {
        case "AddSegue":
            aeBookVC = segue.destination as? AddEditBookViewController
            aeBookVC?.isEditingBook = false
        case "viewDetailSegue":
            let detailBookVC = segue.destination as? BookDetailViewController
            detailBookVC?.book = books[(bookTableView.indexPathForSelectedRow?.row)!]
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
            books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
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

    /*
    // MARK: - Navigation
    */

    // In a storyboard-based application, you will often want to do a little preparation before navigation
}
extension BookTableViewController :  UISearchResultsUpdating{
    public func updateSearchResults(for searchController: UISearchController){
        switch searchController.searchBar.selectedScopeButtonIndex {
        case 0:
            filterContentForSearchText(searchText:searchController.searchBar.text!)
        case 1:
            filterContentForScope(searchBarScopeText:searchController.searchBar.text!)
        default:
            break
        }
        
    }
}
extension BookTableViewController : UISearchControllerDelegate{
    
}
