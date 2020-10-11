//
//  CountryFactsViewModel.swift
//  KnowYourCountry
//
//  Created by Deepti Gupta on 11/10/20.
//  Copyright © 2020 Deepti Gupta. All rights reserved.
//

import Foundation

class CountryFactsViewModel {
    
    static func fetchCountryFacts(completionHandler: @escaping (CountryFacts?, Error?)->(Void)) {
        ServiceManager.getCountryFacts { (data, error) in
            if error != nil {
                completionHandler(nil, error)
            } else if let responseData = data {
                do {
                    let countryFacts: CountryFacts = try JSONDecoder().decode(CountryFacts.self, from: responseData)
                    completionHandler(countryFacts, nil)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
