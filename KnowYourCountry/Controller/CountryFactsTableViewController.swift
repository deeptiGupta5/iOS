//
//  CountryFactsTableViewController.swift
//  KnowYourCountry
//
//  Created by Deepti Gupta on 11/10/20.
//  Copyright © 2020 Deepti Gupta. All rights reserved.
//

import UIKit
import Kingfisher

class CountryFactsTableViewController: UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView! = {
       let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    private let tableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = UIColor.white
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.allowsSelection = false
        return tableview
    }()
    
    var viewModel = CountryFactsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupRefreshControl()
        setupActivityIndicator()
        
        fetchTableData()
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = CountryFactsContants.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CountryFactsTableViewCell.self, forCellReuseIdentifier: TableCellIdentifier.countryFactsCellId)
        
        self.view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupActivityIndicator() {
        activityIndicator.center = self.view.center
        tableView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func fetchTableData() {
        viewModel.fetchCountryFacts { [weak self] error in
            guard let weakSelf = self else { return }

            if let errorMessage = error {
                DispatchQueue.main.async {
                    weakSelf.activityIndicator.stopAnimating()
                    weakSelf.showErrorAlert(message: errorMessage.localizedDescription)
                }
            } else {
                DispatchQueue.main.async {
                    weakSelf.activityIndicator.stopAnimating()
                    weakSelf.title = weakSelf.viewModel.title
                    weakSelf.tableView.reloadData()
                    weakSelf.tableView.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    @objc private func refreshData() {
        fetchTableData()
    }
}

extension CountryFactsTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifier.countryFactsCellId, for: indexPath) as? CountryFactsTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = viewModel.countryInfo?[indexPath.row].title
        cell.descriptionLabel.text = viewModel.countryInfo?[indexPath.row].description
        cell.cellImageView.image = nil

        if let imageURLString = viewModel.countryInfo?[indexPath.row].imageHref, let imageURL = URL(string: imageURLString) {
            let resource = ImageResource(downloadURL: imageURL, cacheKey: imageURL.absoluteString)
            cell.cellImageView.kf.setImage(with: resource, placeholder: #imageLiteral(resourceName: "no-image"), options: [.transition(.fade(0.2)), .cacheOriginalImage])
        } else {
            cell.cellImageView.image = #imageLiteral(resourceName: "no-image")
        }
        
        return cell
    }
}
