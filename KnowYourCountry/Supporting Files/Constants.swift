//
//  Constants.swift
//  KnowYourCountry
//
//  Created by Deepti Gupta on 11/10/20.
//  Copyright © 2020 Deepti Gupta. All rights reserved.
//

import Foundation
import UIKit

struct APIEndpoint {
    static let countryFacts = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
}

struct TableCellIdentifier {
    static let countryFactsCellId = "CountryFactsTableViewCell"
}

struct CountryFactsContants {
    static let countryFactsTableSection = 1
    static let zero = 0
    static let estimatedRowHeight: CGFloat = 200
}

struct CountryFactsTableViewCellContants {
    static let titleLabelFontSize: CGFloat = 20
    static let descriptionLabelFontSize: CGFloat = 14
    static let cellImageSize: CGFloat = 100
    static let padding: CGFloat = 15
}
