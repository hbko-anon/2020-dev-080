//

import Foundation

enum PositionState {
    case empty
    case playerX
    case playerO
    
    
    var localized: String {
        switch self {
        case .empty:
            return "Empty"
        case .playerX:
            return "X"
        case .playerO:
            return "O"
        }
    }
}
