//
//  BankFinderUITests.swift
//  BankFinderUITests
//
//  Created by Mike Camara on 21/6/20.
//  Copyright © 2020 Mike Camara. All rights reserved.
//

import XCTest

class BankFinderUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        self.app = XCUIApplication()
        self.app.launch()
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func test_app_launch() throws {
        let app = XCUIApplication()
        app.launch()
    }
    
    func test_tap_refresh_regions() throws {
        let refreshRegionsButton = self.app.buttons["refreshRegionsButton"]
        refreshRegionsButton.tap()
        let regionsCount = self.app.tables.children(matching: .cell).count
        XCTAssert(regionsCount > 0)
    }
    
    func test_tap_region_row() throws {
        let cellCount = app.tables.cells.count
        XCTAssertTrue(cellCount > 0)
        
        let firstCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
 
        let cellCountBanskRegion = app.tables.cells.count
        XCTAssertTrue(cellCountBanskRegion > 0)
        
        let firstCellBanksRegion = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCellBanksRegion.tap()
        
        let cellCountBankDetails = app.tables.cells.count
        XCTAssertTrue(cellCountBankDetails > 0)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
