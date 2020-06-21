//

import XCTest
@testable import TikTakToe

/// - Tag: unit_tests
class TikTakToeTests: XCTestCase {

    func testGameTile_Starts_empty() throws {
        // arrange
        let tile = GameTile()
        
        // assert
        XCTAssertEqual(tile.position, PositionState.empty, "Game tiles must start empty")
    }

    func testGameBoard_Correct_number_of_starting_tiles() throws {
        // arrange
        let board = GameBoard()
        let boardSize = board.tiles.count
        
        // assert
        XCTAssertEqual(boardSize, GameBoard.BoardSize, "Board must be initialized with \(GameBoard.BoardSize) tiles")
    }
}
