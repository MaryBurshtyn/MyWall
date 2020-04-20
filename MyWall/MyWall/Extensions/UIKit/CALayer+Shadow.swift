import UIKit

// MARK: - Shadow

extension CALayer {
    
    static private let shadowBlurToRadiusFactor: CGFloat = 0.5
    
    func setShadowBlur(_ blur: CGFloat) {
        shadowRadius = blur * CALayer.shadowBlurToRadiusFactor
    }
}
