//

import XCTest
@testable import TikTakToe

/// - Tag: unit_tests
class TikTakToeTests: XCTestCase {
    
    static let ValidFirstPlayer: PositionState = .playerX
    static let ValidSecondPlayer: PositionState = .playerO
    
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
        XCTAssertEqual(boardSize, GameRulesProvider.BoardSize, "Board must be initialized with \(GameRulesProvider.BoardSize) tiles")
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
        let moveByPlayer = Self.ValidFirstPlayer
        let moveAtPosition: Int = 0
        
        XCTAssertTrue(board.tiles.count > moveAtPosition - 1, "Player move must be within the bounds of the board")
        
        // act
        board.moveAt(position: moveAtPosition, state: moveByPlayer)
        
        // assert
        XCTAssertEqual(board.tiles[moveAtPosition].position, moveByPlayer, "Board tiles must be updated after a player move")
    }
    
    func testGameBoard_Not_empty_after_move() throws {
        // arrange
        let board = GameBoard()
        let moveByPlayer = Self.ValidFirstPlayer
        let moveAtPosition: Int = 0
        
        // act
        board.moveAt(position: moveAtPosition, state: moveByPlayer)
        
        // assert
        XCTAssertEqual(board.isEmpty(), false, "After a valid move, the board is no longer empty")
    }
    
    func testGameBoard_Player_moves_to_empty_positions_only() throws {
        // arrange
        let board = GameBoard()
        let firstMoveByPlayer = Self.ValidFirstPlayer
        let firstMoveAtPosition: Int = 0
        board.moveAt(position: firstMoveAtPosition, state: firstMoveByPlayer)
        
        let secondMoveByPlayer = Self.ValidSecondPlayer
        let secondMoveAtPosition = firstMoveAtPosition
        
        // act
        board.moveAt(position: secondMoveAtPosition, state: secondMoveByPlayer)
        
        // assert
        XCTAssertEqual(board.tiles[firstMoveAtPosition].position, firstMoveByPlayer, "Players cannot play on a played position")
    }
    
    func testGameBoard_PlayerX_always_goes_first() throws {
        // arrange
        let board = GameBoard()
        let firstMoveByPlayer = PositionState.playerO
        let firstMoveAtPosition: Int = 0
        XCTAssertNotEqual(firstMoveByPlayer, Self.ValidFirstPlayer)
        
        // act
        board.moveAt(position: firstMoveAtPosition, state: firstMoveByPlayer)
        
        // assert
        XCTAssertEqual(board.tiles[firstMoveAtPosition].position, PositionState.empty, "If playerO tries to play first, the board state should remain unchanged")
    }
    
    func testGameBoard_Players_play_only_once() throws {
        // arrange
        let board = GameBoard()
        
        // act
        // ValidFirstPlayer tries to play twice in a row
        board.moveAt(position: 0, state: Self.ValidFirstPlayer)
        board.moveAt(position: 1, state: Self.ValidFirstPlayer)
        
        // assert
        XCTAssertEqual(board.tiles[0].position, Self.ValidFirstPlayer, "Player's first move must be valid")
        XCTAssertEqual(board.tiles[1].position, PositionState.empty, "If the same player tries to play twice, the board state should remain unchanged")
    }
    
    func testGameBoard_Players_must_alternate() throws {
        // arrange
        let board = GameBoard()
        
        // act
        board.moveAt(position: 0, state: Self.ValidFirstPlayer)
        board.moveAt(position: 1, state: Self.ValidSecondPlayer)
        
        // assert
        XCTAssertEqual(board.tiles[0].position, Self.ValidFirstPlayer, "Player's first move must be valid")
        XCTAssertEqual(board.tiles[1].position, Self.ValidSecondPlayer, "Another players's move must be valid")
    }
    
    func testGameBoard_Alternates_playerX() throws {
        // arrange
        let board = GameBoard()
        let startPlayer = PositionState.playerX
        
        // act
        let alternateResult = try? board.alternate(player: startPlayer)
        
        // assert
        XCTAssertNotNil(alternateResult)
        XCTAssertEqual(alternateResult!, PositionState.playerO, "The alternate of playerX is playerO")
    }
    
    func testGameBoard_Alternates_playerO() throws {
        // arrange
        let board = GameBoard()
        let startPlayer = PositionState.playerO
        
        // act
        let alternateResult = try? board.alternate(player: startPlayer)
        
        // assert
        XCTAssertNotNil(alternateResult)
        XCTAssertEqual(alternateResult!, PositionState.playerX, "The alternate of playerX is playerO")
    }
    
    func testGameBoard_Cant_alternate_empty_tiles() throws {
        // arrange
        let board = GameBoard()
        let startPlayer = PositionState.empty
        
        // assert
        XCTAssertThrowsError(try board.alternate(player: startPlayer))
    }
    
    func testGameBoard_Gameover_after_9_valid_moves() throws {
        // arrange
        let board = GameBoard()
        
        // act
        /*
         X X O
         O O X
         X X O
        */
        board.moveAt(position: 0, state: Self.ValidFirstPlayer)
        board.moveAt(position: 3, state: Self.ValidSecondPlayer)
        
        board.moveAt(position: 1, state: Self.ValidFirstPlayer)
        board.moveAt(position: 4, state: Self.ValidSecondPlayer)
        
        board.moveAt(position: 5, state: Self.ValidFirstPlayer)
        board.moveAt(position: 2, state: Self.ValidSecondPlayer)
        
        board.moveAt(position: 7, state: Self.ValidFirstPlayer)
        board.moveAt(position: 8, state: Self.ValidSecondPlayer)
        board.moveAt(position: 6, state: Self.ValidFirstPlayer)
        
        // assert
        XCTAssertTrue(board.gameOver, "After 9 valid moves the game must be over.")
        XCTAssertEqual(board.winner, GameWinner.draw, "All nine squares are filled and neither player has three in a row, the game is a draw.")
    }
    
    func testGameBoard_Game_not_over_after_4_valid_moves() throws {
        // arrange
        let board = GameBoard()
        var player = Self.ValidFirstPlayer
        let moves: Int = 4
        XCTAssertTrue(moves < GameRulesProvider.BoardSize, "There must be empty tiles remaining after that number of moves.")
        
        
        // act
        for ix in (0...moves-1) {
            board.moveAt(position: ix, state: player)
            guard let nextPlayer = try? board.alternate(player: player) else {
                XCTFail("Invalid alternate for player \(player)")
                return
            }
            player = nextPlayer
        }
        
        // assert
        XCTAssertFalse(board.gameOver, "After \(moves) valid moves the game is not over yet.")
        XCTAssertEqual(board.winner, GameWinner.none)
    }
    
    func testGameBoard_Gameover_when_player_draws_row() throws {
        // arrange
        let board = GameBoard()
        
        // act
        /*
         X X X
         O O -
         - - -
        */
        board.moveAt(position: 0, state: Self.ValidFirstPlayer)
        board.moveAt(position: 3, state: Self.ValidSecondPlayer)
        
        board.moveAt(position: 1, state: Self.ValidFirstPlayer)
        board.moveAt(position: 4, state: Self.ValidSecondPlayer)
        
        XCTAssertFalse(board.gameOver)
        board.moveAt(position: 2, state: Self.ValidFirstPlayer)
        
        // assert
        XCTAssertTrue(board.gameOver, "Game must be over because row of 3 Xs.")
        XCTAssertEqual(board.winner, GameWinner.playerX)
    }
    
    func testGameBoard_Gameover_when_player_draws_column() throws {
        // arrange
        let board = GameBoard()
        
        // act
        /*
         O X X
         O - X
         O - -
        */
        board.moveAt(position: 1, state: Self.ValidFirstPlayer)
        board.moveAt(position: 0, state: Self.ValidSecondPlayer)
        
        board.moveAt(position: 2, state: Self.ValidFirstPlayer)
        board.moveAt(position: 3, state: Self.ValidSecondPlayer)
        
        board.moveAt(position: 5, state: Self.ValidFirstPlayer)
        
        XCTAssertFalse(board.gameOver)
        board.moveAt(position: 6, state: Self.ValidSecondPlayer)
        
        // assert
        XCTAssertTrue(board.gameOver, "Game must be over because column of 3 Os.")
        XCTAssertEqual(board.winner, GameWinner.playerO)
    }
    
    func testGameBoard_Gameover_when_player_draws_diagonal() throws {
        // arrange
        let board = GameBoard()
        
        // act
        /*
         O X X
         O X O
         X - -
        */
        board.moveAt(position: 1, state: Self.ValidFirstPlayer)
        board.moveAt(position: 0, state: Self.ValidSecondPlayer)
        
        board.moveAt(position: 2, state: Self.ValidFirstPlayer)
        board.moveAt(position: 5, state: Self.ValidSecondPlayer)
        
        board.moveAt(position: 4, state: Self.ValidFirstPlayer)
        board.moveAt(position: 3, state: Self.ValidSecondPlayer)
        
        XCTAssertFalse(board.gameOver)
        board.moveAt(position: 6, state: Self.ValidFirstPlayer)
        
        // assert
        XCTAssertTrue(board.gameOver, "Game must be over because diagonal of 3 Xs.")
        XCTAssertEqual(board.winner, GameWinner.playerX)
    }
}
