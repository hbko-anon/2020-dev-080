//

import Foundation
import os.log

class GameBoard: ObservableObject {
    @Published var tiles: [GameTile]

    /// Defines the number of tiles on the board.
    /// e.g. a 3x3 board has 9 tiles.
    static let BoardSize: Int = 9
    
    private var lastPlayer: PositionState? = nil
    
    init() {
        self.tiles = Array(0...Self.BoardSize-1).map({_ in GameTile()})
    }
    
    func moveAt(position: Int, state: PositionState) {
        if self.tiles[position].position != .empty {
            os_log("Attempt to play at non-empty position %d", log: .game, type: .debug, position)
            return
        }
        if state != .playerX && self.isEmpty() {
            os_log("Invalid start player", log: .game, type: .debug)
            return
        }
        if state == lastPlayer {
            os_log("Player attempts to play twice in a row", log: .game, type: .debug)
            return
        }
        self.tiles[position].position = state
        self.lastPlayer = state
    }
    
    /// Returns `true` if the `GameBoard` is currently empty or `false`, if the the `GameBoard` has tiles with state other than `PositionState.empty`
    func isEmpty() -> Bool {
        return !self.tiles.contains(where: {$0.position != .empty})
    }
}
