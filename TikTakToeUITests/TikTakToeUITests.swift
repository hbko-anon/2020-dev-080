//

import XCTest

/// - Tag: ui_tests
class TikTakToeUITests: XCTestCase {
    
    func testStartsReadyToPlay() throws {
        let app = XCUIApplication()
        app.launch()
        
        let gameStatus = app.otherElements.containing(.staticText, identifier: "Next move: X").firstMatch
        XCTAssertTrue(gameStatus.exists, "The game begins announcing the first move")
        
        let emptyButtonCount = app.buttons.matching(identifier: "Empty").count
        XCTAssertEqual(emptyButtonCount, 9, "The game begins with 9 empty tiles for the player to choose from")
    }
    
    func testAnnouncesNextPlayerAfterFirstMove() throws {
        let app = XCUIApplication()
        app.launch()
        
        let emptySpace = app.buttons.matching(identifier: "Empty").firstMatch
        emptySpace.tap()
        
        
        let gameStatus = app.otherElements.containing(.staticText, identifier: "Next move: O").firstMatch
        XCTAssertTrue(gameStatus.exists, "The next player is announced")
    }
    
    func testAllowsThePlayerToReachTheEndOfTheGame() throws {
        let app = XCUIApplication()
        app.launch()
        
        let myNextMove = app.buttons.matching(identifier: "Empty").firstMatch
        let gameEndsX = app.otherElements.containing(.staticText, identifier: "Winner player X! 🏆").firstMatch
        let gameEndsO = app.otherElements.containing(.staticText, identifier: "Winner player X! 🏆").firstMatch
        let gameEndsDraw = app.otherElements.containing(.staticText, identifier: "Game is a draw!").firstMatch
        
        XCTAssertFalse(gameEndsX.exists, "The game can't be over before any player moves")
        XCTAssertFalse(gameEndsO.exists, "The game can't be over before any player moves")
        XCTAssertFalse(gameEndsDraw.exists, "The game can't be over before any player moves")
        
        
        while !gameEndsX.exists && !gameEndsO.exists && !gameEndsDraw.exists {
            myNextMove.tap()
        }
        
        XCTAssertTrue(gameEndsX.exists || gameEndsO.exists || gameEndsDraw.exists)
    }
}
