//
//  CountryFacts.swift
//  KnowYourCountry
//
//  Created by Deepti Gupta on 11/10/20.
//  Copyright © 2020 Deepti Gupta. All rights reserved.
//

import Foundation

struct CountryInfo: Decodable {
    var title: String?
    var description: String?
    var imageHref: String?
}


struct CountryFacts: Decodable {
    var title: String?
    var rows: [CountryInfo]?
}
