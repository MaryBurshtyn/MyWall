import UIKit

extension UIColor {
    
    static private let changeBrightnessStep: CGFloat = 0.2
    static private let maxBrightness: CGFloat = 1.0
    
    var darkerColor: UIColor {
        return lighterColor(addBrightness: -UIColor.changeBrightnessStep)
    }
    
    func lighterColor(addBrightness val: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else {
            return self
        }
        
        return UIColor(hue: hue,
                       saturation: saturation,
                       brightness: min(brightness + val, UIColor.maxBrightness),
                       alpha: alpha)
    }
}
