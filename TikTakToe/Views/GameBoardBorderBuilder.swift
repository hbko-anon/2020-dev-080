//

import SwiftUI

struct GameBoardBorderBuilder<Content: View>: View {
    let content: Content
    let row: Int
    let column: Int
    let BorderWidth: CGFloat = 4
    
    init(row: Int, column: Int, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.row = row
        self.column = column
    }
    
    var body: some View {
        switch (row, column) {
        case (0, 0), (0, 1), (1, 0), (1, 1):
            return AnyView(content
                .border(width: self.BorderWidth, edge: .trailing, color: Color.black)
                .border(width: self.BorderWidth, edge: .bottom, color: Color.black))
        case (0, 2), (1, 2):
            return AnyView(content
                .border(width: self.BorderWidth, edge: .bottom, color: Color.black))
        case (2, 1):
            return AnyView(content
                .border(width: self.BorderWidth, edge: .trailing, color: Color.black))
        case (2, 0):
        return AnyView(content
            .border(width: self.BorderWidth, edge: .trailing, color: Color.black))
        default:
            return AnyView(content)
        }
    }
}
