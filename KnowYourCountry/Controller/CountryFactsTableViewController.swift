//
//  CountryFactsTableViewController.swift
//  KnowYourCountry
//
//  Created by Deepti Gupta on 11/10/20.
//  Copyright © 2020 Deepti Gupta. All rights reserved.
//

import UIKit

class CountryFactsTableViewController: UITableViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel = CountryFactsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        activityIndicator.startAnimating()
        
        viewModel.fetchCountryFacts { [weak self] error in
            guard let weakSelf = self else { return }

            DispatchQueue.main.async {
                weakSelf.activityIndicator.stopAnimating()
                weakSelf.title = weakSelf.viewModel.title
                weakSelf.tableView.reloadData()
            }
        }
    }
}

extension CountryFactsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifier.countryFactsCellId, for: indexPath)
        cell.textLabel?.text = viewModel.countryInfo?[indexPath.row].title
        cell.detailTextLabel?.text = viewModel.countryInfo?[indexPath.row].description
        return cell
    }
}
