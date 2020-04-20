import UIKit

class AppearanceConfig: AppearanceConfigProtocol {
    func setup() {
        
    }
    

    let navigationBarShadowOpacity: Float = 0.18
    let navigationBarhadowOffset = CGSize(width: 0, height: 2)
    let navigationBarShadowBlur: CGFloat = 4
    
    //let colors: AppearanceColorsConfigProtocol = AppearanceColorsConfig()
    //var fonts: AppearanceFontsConfigProtocol = AppearanceFontsConfig()

    // MARK: - String attributes

    let linkAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: #colorLiteral(red: 0.01864526048, green: 0.4776622653, blue: 1, alpha: 1),
        .underlineStyle: NSUnderlineStyle.single.rawValue]
}
