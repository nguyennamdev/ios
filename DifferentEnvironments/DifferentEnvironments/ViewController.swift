//
//  ViewController.swift
//  DifferentEnvironments
//
//  Created by Nguyen Nam on 7/7/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let server_url = Environment().configuration(plistKey: .ServerURL) else { return }
        print(server_url)
    }

}

