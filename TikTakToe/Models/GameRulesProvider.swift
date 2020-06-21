//

import Foundation
import os.log

class GameRulesProvider {
    
    /// Defines the number of tiles on the board.
    /// e.g. a 3x3 board has 9 tiles.
    static let BoardSize: Int = 9
    
    /// Defines the possible combination of positions for a player to win the game.
    static let WinCombinations: [[Int]] = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]
    
    
    /// Checks if a given move is valid or not.
    /// - Returns: `true` if the move is allowed or `false` if the move is illegal
    static func isValid(move: PositionState, at position: Int, tiles: [GameTile], lastPlayer: PositionState?) -> Bool {
        
        if tiles[position].position != .empty {
            os_log("Attempt to play at non-empty position %d", log: .game, type: .debug, position)
            return false
        }
        if move != .playerX && isEmpty(tiles: tiles) {
            os_log("Invalid start player", log: .game, type: .debug)
            return false
        }
        if move == lastPlayer {
            os_log("Player attempts to play twice in a row", log: .game, type: .debug)
            return false
        }
        
        return true
    }
    
    /// Checks if the board is currently empty.
    /// - Returns: `true` if the board is empty or `false` if one or more positions are occupied by a player
    static func isEmpty(tiles: [GameTile]) -> Bool {
        return !tiles.contains(where: {$0.position != .empty})
    }
    
    /// Returns the alternate player. For example, the alternate of player X is player O and vis-versa.
    static func alternate(player: PositionState) throws -> PositionState {
        switch player {
        case .empty:
            throw GameRulesError.rulesViolation
        case .playerX:
            return .playerO
        case .playerO:
            return .playerX
        }
    }
    
    /// Checks if the game is finished or not.
    /// - Returns: `true` if the game is over and no more moves are allowed or `false` if a next move is possible
    static func isGameOver(tiles: [GameTile]) -> GameWinner {
        
        if let winner = getWinner(tiles: tiles) {
            return winner
        }
        
        if !tiles.contains(where: {$0.position == .empty}) {
            // all tiles are occupied
            return GameWinner.draw
        }
        
        // if we are here, the game is still on
        return GameWinner.none
    }
    
    static func getWinner(tiles: [GameTile]) -> GameWinner? {
        for winCombo in WinCombinations {
            // get the current tile state on the win positions
            let stateForCombo = winCombo.map({tiles[$0].position})
            
            // we have a winner if all tiles are occupied by the same player
            if let firstPlayer = stateForCombo.first {
                if stateForCombo.allSatisfy({$0 != .empty && $0 == firstPlayer}) {
                    switch firstPlayer {
                    case .playerX:
                        return GameWinner.playerX
                    case .playerO:
                        return GameWinner.playerO
                    default:
                        break
                    }
                }
            }
        }
        
        // no winner
        return nil
    }
    
    enum GameRulesError: Error {
        case rulesViolation
    }
}
