//

import SwiftUI

struct GameTileView: View {
    var tile: GameTile
    var action: () -> Void
    
    var tileIcon: Image {
        switch self.tile.position {
        case .empty:
            return Image(uiImage: UIImage())
        case .playerX:
            return Image(systemName: "xmark")
        case .playerO:
            return Image(systemName: "circle")
        }
    }
    
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            tileIcon
                .imageScale(.large)
                .padding()
                .foregroundColor(Color.primary)
                .font(.largeTitle)
        }).frame(width: 100, height: 100)
    }
}

struct GameTileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameTileView(tile: GameTile(position: .empty), action: {})
            GameTileView(tile: GameTile(position: .playerX), action: {})
            GameTileView(tile: GameTile(position: .playerO), action: {})
        }.previewLayout(.sizeThatFits)
    }
}
