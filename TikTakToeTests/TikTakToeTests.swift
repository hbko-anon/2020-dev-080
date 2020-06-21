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
    
    func testGameBoard_Starts_empty() throws {
        // arrange
        let board = GameBoard()
        
        // assert
        XCTAssertEqual(board.isEmpty(), true, "All tiles must be initialized empty")
    }
    
    func testGameBoard_Player_moves_at_position() throws {
        // arrange
        let board = GameBoard()
        let moveByPlayer = PositionState.playerX
        let moveAtPosition: Int = 0
        
        XCTAssertTrue(board.tiles.count > moveAtPosition - 1, "Player move must be within the bounds of the board")
        
        // act
        board.moveAt(position: moveAtPosition, state: moveByPlayer)
        
        // assert
        XCTAssertEqual(board.tiles[0].position, moveByPlayer, "Board tiles must be updated after a player move")
    }
    
    func testGameBoard_Not_empty_after_move() throws {
        // arrange
        let board = GameBoard()
        let moveByPlayer = PositionState.playerX
        let moveAtPosition: Int = 0
        
        // act
        board.moveAt(position: moveAtPosition, state: moveByPlayer)
        
        // assert
        XCTAssertEqual(board.isEmpty(), false, "After a valid move, the board is no longer empty")
    }
    
    func testGameBoard_Player_moves_to_empty_positions_only() throws {
        // arrange
        let board = GameBoard()
        let firstMoveByPlayer = PositionState.playerX
        let firstMoveAtPosition: Int = 0
        board.moveAt(position: firstMoveAtPosition, state: firstMoveByPlayer)
        
        let secondMoveByPlayer = PositionState.playerO
        let secondMoveAtPosition: Int = 0
        
        // act
        board.moveAt(position: secondMoveAtPosition, state: secondMoveByPlayer)
        
        // assert
        XCTAssertEqual(board.tiles[0].position, firstMoveByPlayer, "Players cannot play on a played position")
    }
    
    func testGameBoard_PlayerX_always_goes_first() throws {
        // arrange
        let board = GameBoard()
        let firstMoveByPlayer = PositionState.playerO
        let firstMoveAtPosition: Int = 0
        board.moveAt(position: firstMoveAtPosition, state: firstMoveByPlayer)
        
        // act
        board.moveAt(position: firstMoveAtPosition, state: firstMoveByPlayer)
        
        // assert
        XCTAssertEqual(board.tiles[0].position, PositionState.empty, "If playerO tries to play first, the board state should remain unchanged")
    }
    
}
