//
//  CountryFactsViewModel.swift
//  KnowYourCountry
//
//  Created by Deepti Gupta on 11/10/20.
//  Copyright © 2020 Deepti Gupta. All rights reserved.
//

import Foundation

class CountryFactsViewModel {
    
    var title: String?
    var countryInfo: [CountryInfo]?
    
    /// Fetch Country Facts from server
    /// - Parameter completionHandler: closure to mark the response/error recieved
    func fetchCountryFacts(networkType: NETWORKTYPE = .API, completionHandler: @escaping (Error?)->(Void)) {
        let serviceManger = ServiceManager(networkType: networkType)
        serviceManger.getCountryFacts { [weak self] (data, error) in
            guard let weakSelf = self else { return }
            if error != nil {
                completionHandler(error)
            } else if let responseData = data {
                do {
                    let countryFacts: CountryFacts = try JSONDecoder().decode(CountryFacts.self, from: responseData)
                    weakSelf.title = countryFacts.title
                    weakSelf.countryInfo = countryFacts.rows
                    completionHandler(nil)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    /// Return number of sections for table
    /// - Returns: section count
    func numberOfSections() -> Int {
        return CountryFactsContants.countryFactsTableSection
    }
    
    /// Return number of rows in a section for table
    /// - Parameter section: table section
    /// - Returns: row count in the passed section
    func numberOfRowsInSection(_ section: Int) -> Int {
        return countryInfo?.count ?? CountryFactsContants.zero
    }
}
