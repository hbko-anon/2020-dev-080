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
    
    func testGameBoard_Player_moves_at_position() throws {
        // arrange
        let board = GameBoard()
        let moveByPlayer = PositionState.playerA
        let moveAtPosition: Int = 0
        
        XCTAssertTrue(board.tiles.count > moveAtPosition - 1, "Player move must be within the bounds of the board")
        
        // act
        board.moveAt(position: moveAtPosition, state: moveByPlayer)
        
        // assert
        XCTAssertEqual(board.tiles[0].position, moveByPlayer, "Board tiles must be updated after a player move")
    }
}
