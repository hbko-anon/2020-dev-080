//

import Foundation
import os.log

class GameRulesProvider {
    
    /// Defines the number of tiles on the board.
    /// e.g. a 3x3 board has 9 tiles.
    static let BoardSize: Int = 9
    
    
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
}
