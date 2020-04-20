import UIKit

extension UINavigationController {
    convenience init<T: AppearanceСonfigurable>(navigationBarClass: T.Type,
                                                rootViewController: UIViewController,
                                                appearanceConfig: AppearanceConfigProtocol) {
        self.init(navigationBarClass: navigationBarClass as? AnyClass, toolbarClass: nil)
        self.viewControllers = [rootViewController]
        
        guard let navigationBar = self.navigationBar as? T else {
            fatalError("Navigation bar doesn't conform to AppearanceConfigurable protocol")
        }
        
        navigationBar.setupWithAppearanceConfig(appearanceConfig)
    }
}
