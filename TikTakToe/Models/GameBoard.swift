//

import Foundation

class GameBoard: ObservableObject {
    @Published var tiles: [GameTile]
    @Published var gameOver: Bool = false
    @Published var winner: GameWinner = .none

    private var lastPlayer: PositionState? = nil
    
    init() {
        self.tiles = Array(0...GameRulesProvider.BoardSize-1).map({ix in GameTile(position: .empty)})
    }
    
    func moveAt(position: Int, state: PositionState) {
        if !GameRulesProvider.isValid(move: state, at: position, tiles: self.tiles, lastPlayer: self.lastPlayer) {
            return
        }
        self.tiles[position] = GameTile(position: state)
        self.lastPlayer = state
        self.onPlayerMoved()
    }
    
    private func onPlayerMoved() {
        let gameWinnerState = GameRulesProvider.getWinnerState(tiles: self.tiles)
        self.gameOver = gameWinnerState != .none
        self.winner = gameWinnerState
    }
    
    /// Returns `true` if the `GameBoard` is currently empty or `false`, if the the `GameBoard` has tiles with state other than `PositionState.empty`
    func isEmpty() -> Bool {
        return GameRulesProvider.isEmpty(tiles: self.tiles)
    }
    
    /// Returns the alternate player. For example, the alternate of player X is player O and vis-versa.
    func alternate(player: PositionState) throws -> PositionState {
        return try GameRulesProvider.alternate(player: player)
    }
    
    func nextPlayer() -> PositionState {
        if let lastPlayer = self.lastPlayer, let nextPlayer = try? self.alternate(player: lastPlayer) {
            return nextPlayer
        }
        return PositionState.playerX
    }
}
