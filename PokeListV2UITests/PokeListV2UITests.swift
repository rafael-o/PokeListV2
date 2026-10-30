//
//  PokeListV2UITests.swift
//  PokeListV2UITests
//
//  Created by Rafael de Oliveira on 10/28/26.
//

import XCTest

final class PokeListV2UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testNavigationToFavorites() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Tap the star button in the navigation bar to go to the Favorites view.
        let navBar = app.navigationBars["Pokémon"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5), "Navigation bar should exist")
        let starButton = navBar.buttons["star"]
        XCTAssertTrue(starButton.waitForExistence(timeout: 5), "Star button should exist")
        starButton.tap()
        
        // Wait for the favorites view to appear.
        let favoritesNav = app.navigationBars["Favoritos"]
        XCTAssertTrue(favoritesNav.waitForExistence(timeout: 5), "Favorites view navigation bar should appear")
    }
    
    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Verify that the navigation bar title "Pokémon" exists.
        let navBar = app.navigationBars["Pokémon"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5), "Navigation bar with title 'Pokémon' should exist")
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
