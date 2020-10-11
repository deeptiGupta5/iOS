//
//  KnowYourCountryTests.swift
//  KnowYourCountryTests
//
//  Created by Deepti Gupta on 11/10/20.
//  Copyright © 2020 Deepti Gupta. All rights reserved.
//

import XCTest
@testable import KnowYourCountry

class KnowYourCountryTests: XCTestCase {
    
    var viewModel = CountryFactsViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchCountryFacts() {
        viewModel.fetchCountryFacts(networkType: .MOCK) { (error) -> (Void) in
            XCTAssertNotNil(self.viewModel.title)
            XCTAssertNotNil(self.viewModel.countryInfo)
            
            if let countryInfo = self.viewModel.countryInfo {
                XCTAssertTrue(countryInfo.count > 0)
            }
        }
    }
    
    func testNumberOfSections() {
        XCTAssertTrue(viewModel.numberOfSections() == 1)
    }
    
    func testNumberOfRowsInSection() {
        XCTAssertTrue(viewModel.numberOfRowsInSection(0) == 0)

        viewModel.fetchCountryFacts(networkType: .MOCK) { (error) -> (Void) in
            XCTAssertTrue(self.viewModel.numberOfRowsInSection(0) == self.viewModel.countryInfo?.count)
        }
    }
}
