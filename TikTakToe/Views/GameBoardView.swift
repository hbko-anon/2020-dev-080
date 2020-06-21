//

import SwiftUI

struct BoardGridWrapper: View {
    @Binding var tiles: [GameTile]
    var onSelectTile: (Int) -> Void
    
    func position(_ row: Int, _ col: Int) -> Int {
        return row * 3 + col
    }
    
    func tileLabel(row: Int, column: Int) -> Text {
        return Text(self.tiles[self.position(row, column)].position.localized)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { row in
                HStack(spacing: 0) {
                    ForEach(0..<3) { column in
                        GameBoardBorderBuilder(row: row, column: column) {
                            GameTileView(tile: self.tiles[self.position(row, column)], action: {
                                self.onSelectTile(self.position(row, column))
                            }).accessibility(label: self.tileLabel(row: row, column: column))
                        }
                    }
                }
            }
        }.frame(width: 300, height: 300)
    }
}

struct GameBoardView: View {
    @ObservedObject private var gameBoard: GameBoard = GameBoard()
    let userPlayer: PositionState = .playerX
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State var lastUpdate: Date = Date()
    
    
    var GameStatusLabel: some View {
        switch self.gameBoard.winner {
        case .none:
            let nextPlayer = self.gameBoard.nextPlayer()
            return Text("Next move: \(nextPlayer.localized)")
        case .playerX:
            return Text("Winner player \(PositionState.playerX.localized)! 🏆")
        case .playerO:
            return Text("Winner player \(PositionState.playerO.localized)! 🏆")
        case .draw:
            return Text("Game is a draw!")
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                self.GameStatusLabel
            }
            BoardGridWrapper(tiles: self.$gameBoard.tiles, onSelectTile: { position in
                self.onExecuteMove(at: position)
            })
            
        }.id(self.lastUpdate)
        .onReceive(self.timer, perform: {_ in
            if self.gameBoard.winner == .none, self.gameBoard.nextPlayer() != self.userPlayer {
                self.onExecuteAiMove()
            }
        })
    }
    
    func onExecuteMove(at: Int) {
        self.gameBoard.moveAt(position: at, state: self.userPlayer)
        self.lastUpdate = Date()
    }
    
    func onExecuteAiMove() {
        if let aiIdentity = try? self.gameBoard.alternate(player: self.userPlayer), let tilePosition = GameAiPlayer.nextMovePosition(tiles: self.gameBoard.tiles) {
            self.gameBoard.moveAt(position: tilePosition, state: aiIdentity)
            self.lastUpdate = Date()
        }
    }
}

struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView()
    }
}
