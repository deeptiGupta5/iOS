//
//  ServiceManager.swift
//  KnowYourCountry
//
//  Created by Deepti Gupta on 11/10/20.
//  Copyright © 2020 Deepti Gupta. All rights reserved.
//

import Foundation

enum NETWORKTYPE {
    case API
    case MOCK
}

class ServiceManager {
    
    var networkType: NETWORKTYPE
    
    init(networkType: NETWORKTYPE = .API) {
        self.networkType = networkType
    }
    
    /// Get URL object for API endpoint/ Local JSON
    /// - Returns: URL object
    private func getURL() -> URL? {
        switch self.networkType {
        case .API:
            return URL(string: APIEndpoint.countryFacts)
        case .MOCK:
            return Bundle.main.url(forResource: "CountryFacts", withExtension: "json")
        }
    }
    
    /// Get Data object from local mock JSON file
    /// - Parameter url: url of local file
    /// - Returns: Data object
    private func getDataFromMockJSON(_ url: URL) -> Data? {
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
    /// Get data from API or Local JSON as per initialized network type
    /// - Parameter completionHandler: closure to reurn data & error, once response is recieved
    func getCountryFacts(completionHandler: @escaping (Data?, Error?)->(Void)) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession.init(configuration: configuration)
        
        if let url = getURL() {
            switch self.networkType {
            case .API:
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
            case .MOCK:
                completionHandler(getDataFromMockJSON(url), nil)
            }
        }
    }
}
