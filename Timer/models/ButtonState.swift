import Foundation
import SwiftUI

enum ButtonState {
    case start
    case cancel
    case pause
    case restart

    var backgroundColor: Color {
        switch self {
        case .start:
            return .mint
        case .cancel:
            return .gray
        case .pause:
            return .pink
        case .restart:
            return .mint
        }
    }

    var buttonText: String {
        switch self {
        case .start:
            return "スタート"
        case .cancel:
            return "キャンセル"
        case .pause:
            return "一時停止"
        case .restart:
            return "再開"
        }
    }
}
