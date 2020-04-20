import UIKit

class ShadowNavigationBar: UINavigationBar, AppearanceСonfigurable {
    
    var appearanceConfig: AppearanceConfigProtocol! {
        didSet {
            guard oldValue == nil else {
                fatalError("AppearanceConfig can be set only once -- during assembling \(self.description)")
            }
        }
    }
    
    func setupWithAppearanceConfig(_ config: AppearanceConfigProtocol) {
        appearanceConfig = config
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        //layer.shadowColor = appearanceConfig.colors.shadow.cgColor
    }
}
