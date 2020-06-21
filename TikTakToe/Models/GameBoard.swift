//

import Foundation

class GameBoard: ObservableObject {
    @Published var tiles: [GameTile]
    @Published var gameOver: Bool = false

    private var lastPlayer: PositionState? = nil
    
    init() {
        self.tiles = Array(0...GameRulesProvider.BoardSize-1).map({_ in GameTile()})
    }
    
    func moveAt(position: Int, state: PositionState) {
        if !GameRulesProvider.isValid(move: state, at: position, tiles: self.tiles, lastPlayer: self.lastPlayer) {
            return
        }
        self.tiles[position].position = state
        self.lastPlayer = state
        self.gameOver = GameRulesProvider.isGameOver(tiles: self.tiles)
    }
    
    /// Returns `true` if the `GameBoard` is currently empty or `false`, if the the `GameBoard` has tiles with state other than `PositionState.empty`
    func isEmpty() -> Bool {
        return GameRulesProvider.isEmpty(tiles: self.tiles)
    }
    
    /// Returns the alternate player. For example, the alternate of player X is player O and vis-versa.
    func alternate(player: PositionState) throws -> PositionState {
        return try GameRulesProvider.alternate(player: player)
    }
}
