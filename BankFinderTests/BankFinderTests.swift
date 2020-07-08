//
//  BankFinderTests.swift
//  BankFinderTests
//
//  Created by Mike Camara on 21/6/20.
//  Copyright © 2020 Mike Camara. All rights reserved.
//

import XCTest
@testable import BankFinder

class BankFinderTests: XCTestCase {
    
    var urlSession: URLSession!
    
    override func setUp() {
        super.setUp()
        urlSession = URLSession(configuration: .default)
    }

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        urlSession = nil
        super.tearDown()
    }

    func testExample() throws {
    }

    func testPerformanceExample() throws {
        self.measure {
            self.testValidCallToSwedGetEstonianBanksHTTPStatusCode200()
            self.testValidCallToSwedGetLatvianBanksHTTPStatusCode200()
            self.testValidCallToSwedGetLithuaninaBanksHTTPStatusCode200()
        }
    }
    
    func testValidCallToSwedGetEstonianBanksHTTPStatusCode200() {
        let apiUrlEstonia = "https://www.swedbank.ee/finder.json"
        let url = URL(string: apiUrlEstonia)
        let promise = expectation(description: "Status code: 200")

        let dataTask = urlSession.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
    
    func testValidCallToSwedGetLatvianBanksHTTPStatusCode200() {
        let apiUrlLatvia = "https://ib.swedbank.lv/finder.json"
        let url = URL(string: apiUrlLatvia)
        let promise = expectation(description: "Status code: 200")

        let dataTask = urlSession.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
    
    func testValidCallToSwedGetLithuaninaBanksHTTPStatusCode200() {
        let apiUrlLithuania = "https://ib.swedbank.lt/finder.json"
        let url = URL(string: apiUrlLithuania)
        let promise = expectation(description: "Status code: 200")

        let dataTask = urlSession.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
}
