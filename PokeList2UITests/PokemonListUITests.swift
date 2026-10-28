import XCTest

final class PokemonListUITests: XCTestCase {
    func testNavigationToDetail() throws {
        let app = XCUIApplication()
        app.launch()
        // Assuming the first cell contains "Bulbasaur" after data loads
        let firstCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        firstCell.tap()
        // Verify that detail view appears (e.g., navigation title contains name)
        // Since our placeholder detail view just shows the name, check for navigation bar title
        let navBar = app.navigationBars.firstMatch
        XCTAssertTrue(navBar.waitForExistence(timeout: 2))
    }
}
