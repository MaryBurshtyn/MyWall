import Foundation
import UIKit

class LabelWithInsets: UILabel {
    
    private var insetX: CGFloat = 0.0
    private var insetY: CGFloat = 0.0
    
    convenience init(frame: CGRect, insetX: CGFloat, insetY: CGFloat) {
        self.init(frame: frame)
        self.insetX = insetX
        self.insetY = insetY
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: insetX, dy: insetY))
    }
}
