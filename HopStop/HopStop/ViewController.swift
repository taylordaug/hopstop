//
//  ViewController.swift
//  HopStop
//
//  Created by Taylor Daugherty on 5/6/17.
//  Copyright © 2017 HopStop. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UISearchResultsUpdating {
    
    @IBOutlet var tableView: UITableView!
    
    let beers = ["Modern Times: Effective Dreams", "Stone: Go-To IPA", "Ballast Point: Grapefruit Sculpin"]
    
    var filteredBeers: [String]?
    
    var searchController: UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        tableView.tableHeaderView = searchController.searchBar
        
        
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.sizeToFit()
        
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text {
            filteredBeers = searchString.isEmpty ? nil : beers.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchString, options: .caseInsensitive) != nil
            })
            
            tableView.reloadData()
        }
    }
    
}

extension SearchResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filteredBeers = filteredBeers?.count {
            return filteredBeers
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell")! as UITableViewCell
        cell.textLabel?.text = filteredBeers?[indexPath.row]
        return cell
    }
    
}
