//
//  ServiceManager.swift
//  KnowYourCountry
//
//  Created by Deepti Gupta on 11/10/20.
//  Copyright © 2020 Deepti Gupta. All rights reserved.
//

import Foundation

class ServiceManager {
    
    static func getCountryFacts(completionHandler: @escaping (Data?, Error?)->(Void)) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession.init(configuration: configuration)
        
        if let url = URL(string: APIEndpoint.countryFacts) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
                   
            session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completionHandler(nil, error)
                } else if let responseData = data {
                    let asciiServerResponse = String(data: responseData, encoding: .ascii)!
                    let utf8Data = Data(asciiServerResponse.utf8)
                    
                    completionHandler(utf8Data, nil)
                }
            }.resume()
        }
    }
}
