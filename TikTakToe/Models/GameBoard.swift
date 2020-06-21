//

import Foundation

class GameBoard: ObservableObject {
    @Published var tiles: [GameTile]

    /// Defines the number of tiles on the board.
    /// e.g. a 3x3 board has 9 tiles.
    static let BoardSize: Int = 9
    
    init() {
        self.tiles = Array(0...Self.BoardSize-1).map({_ in GameTile()})
    }
    
    func moveAt(position: Int, state: PositionState) {
        if self.tiles[position].position != .empty {
            return
        }
        if state != .playerX && self.isEmpty() {
            return
        }
        self.tiles[position].position = state
    }
    
    /// Returns `true` if the `GameBoard` is currently empty or `false`, if the the `GameBoard` has tiles with state other than `PositionState.empty`
    func isEmpty() -> Bool {
        return !self.tiles.contains(where: {$0.position != .empty})
    }
}
