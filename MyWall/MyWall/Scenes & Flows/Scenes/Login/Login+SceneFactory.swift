import Foundation
import UIKit

extension SceneFactory {
    static func makeLoginModule(navigator: SceneNavigatorProtocol, appearenceConfig: AppearanceConfigProtocol, api: ApiProtocol) -> LoginViewController {
        let viewController: LoginViewController = LoginViewController.storyboardInstance()
        viewController.appearanceConfig = appearenceConfig
        let presenter = LoginPresenter(view: viewController,
                                        navigator: navigator, api: api)
        viewController.presenter = presenter
        
        return viewController
    }
}
