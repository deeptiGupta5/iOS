//
//  CountryFactsTableViewController.swift
//  KnowYourCountry
//
//  Created by Deepti Gupta on 11/10/20.
//  Copyright © 2020 Deepti Gupta. All rights reserved.
//

import UIKit
import Kingfisher

class CountryFactsTableViewController: UITableViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel = CountryFactsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension
        
        activityIndicator.startAnimating()
        fetchTableData()
    }
    
    private func fetchTableData() {
        viewModel.fetchCountryFacts { [weak self] error in
            guard let weakSelf = self else { return }

            DispatchQueue.main.async {
                weakSelf.activityIndicator.stopAnimating()
                weakSelf.title = weakSelf.viewModel.title
                weakSelf.tableView.reloadData()
                weakSelf.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    @objc private func refreshData() {
        fetchTableData()
    }
}

extension CountryFactsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifier.countryFactsCellId, for: indexPath) as? CountryFactsTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = viewModel.countryInfo?[indexPath.row].title
        cell.descriptionLabel.text = viewModel.countryInfo?[indexPath.row].description
        cell.cellImageView?.image = nil
        
        if let imageURLString = viewModel.countryInfo?[indexPath.row].imageHref, let imageURL = URL(string: imageURLString) {
            let resource = ImageResource(downloadURL: imageURL, cacheKey: imageURL.absoluteString)
            cell.cellImageView?.kf.setImage(with: resource, options: [.transition(.fade(0.2)), .cacheOriginalImage])
        }
        return cell
    }
}
