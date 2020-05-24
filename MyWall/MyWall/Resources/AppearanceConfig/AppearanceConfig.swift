import UIKit

class AppearanceConfig: AppearanceConfigProtocol {
    let navigationBarShadowOpacity: Float = 0.18
    let navigationBarhadowOffset = CGSize(width: 0, height: 2)
    let navigationBarShadowBlur: CGFloat = 4
    static private let backButtonOffset = UIOffset(horizontal: -1000, vertical: 0)
    let colors: AppearanceColorsConfigProtocol = AppearanceColorsConfig()
    
    func setup() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.barTintColor = colors.navBarColor
        navigationBar.tintColor = colors.navigationBarButtonColor
        //navigationBar.backgroundColor = colors.navBarColor
        navigationBar.layer.shadowOffset = navigationBarhadowOffset
        navigationBar.layer.setShadowBlur(navigationBarShadowBlur)
        navigationBar.layer.shadowColor = colors.shadow.cgColor
        navigationBar.layer.shadowOpacity = navigationBarShadowOpacity
        setupBarButtonItem()
    }
    
    private func setupBarButtonItem() {
           let barButtonItem = UIBarButtonItem.appearance()
           barButtonItem.tintColor = colors.navigationBarButtonColor
           barButtonItem.setBackButtonTitlePositionAdjustment(AppearanceConfig.backButtonOffset,
                                                              for: UIBarMetrics.default)
       }
    
    
    
    //var fonts: AppearanceFontsConfigProtocol = AppearanceFontsConfig()

    // MARK: - String attributes

    let linkAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: #colorLiteral(red: 0.01864526048, green: 0.4776622653, blue: 1, alpha: 1),
        .underlineStyle: NSUnderlineStyle.single.rawValue]
}
