//
//  ViewController.swift
//  Parsing-JSON-Using-URLSession
//
//  Created by Liubov Kaper  on 8/4/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class StationsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    let apiClient = APIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
       
    }
    
    private func fetchData() {
        // result type has two values
        //1. .failure() 2. .success()
        apiClient.fetchData { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let stations):
                dump(stations)
            }
        }
    }

    private func updateSnapshot() {
    
    }

}

