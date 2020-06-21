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
        self.tiles[position].position = state
    }
}
