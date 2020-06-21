//

import Foundation
import os.log

extension OSLog {
    
    // MARK: - Types -
    
    private enum CustomCategory: String {
        case game
    }
    
    // MARK: - Properties -
    
    private static let subsystem: String = {
        guard let identifier = Bundle.main.bundleIdentifier else { fatalError() }
        return identifier
    }()
    
    static let game = OSLog(subsystem: subsystem, category: CustomCategory.game.rawValue)
}
