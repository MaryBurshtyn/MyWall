import Foundation
extension String {
    var isNumeric: Bool {
        return range(of: "[^0-9\\.^0-9]", options: .regularExpression) == nil
    }
}
