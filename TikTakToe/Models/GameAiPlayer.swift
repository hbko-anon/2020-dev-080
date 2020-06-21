//

import Foundation

/// A virtual player which by "seeing" the tiles on the board can decide to make a next move.
class GameAiPlayer {
    
    /// Calculates the next position where the player will make a move.
    /// Returns `nil` if there is no next move the player can make or an `Int` corresponding the tile index where the player will move.
    static func nextMovePosition(tiles: [GameTile]) -> Int? {
        if !tiles.contains(where: {$0.position == .empty}) {
            return nil
        }
        
        let maxPosition = tiles.count - 1
        var nextPosition = Int.random(in: 0...maxPosition)
        
        while (tiles[nextPosition].position != .empty) {
            nextPosition = Int.random(in: 0...maxPosition)
        }
        
        return nextPosition
    }
}
