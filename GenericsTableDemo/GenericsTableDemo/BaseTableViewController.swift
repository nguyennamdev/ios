//
//  BaseTableViewController.swift
//  GenericsTableDemo
//
//  Created by Nguyen Nam on 7/4/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit

class BaseTableViewController<T: BaseCell<U>, U>: UITableViewController {
    
    let cellId = "cellId"
    var items: [U]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(T.self, forCellReuseIdentifier: cellId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BaseCell<U>
        cell.item = items[indexPath.row]
        return cell
    }
    
}

class BaseCell<U>: UITableViewCell {
    var item:U!
}

struct Cat{
    var name: String
    var age: Int
}

class CatCell: BaseCell<Cat>{

    override var item: Cat!{
        didSet{
            textLabel?.text = item.name
            detailTextLabel?.text = "\(item.age)"
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .blue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BlueTableView: BaseTableViewController<CatCell, Cat>{

    override func viewDidLoad() {
        super.viewDidLoad()
        items = [
            Cat(name: "Kitty", age: 1),
            Cat(name: "Mew mew", age: 2)
        ]
    }
    
    
}


