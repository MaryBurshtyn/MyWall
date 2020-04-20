import Foundation

import UIKit

extension SceneFactory {
    static func makeSplashModule(navigator: SceneNavigatorProtocol) -> SplashViewController {
        let viewController: SplashViewController = SplashViewController.storyboardInstance()
        let presenter = SplashPresenter(view: viewController,
                                        navigator: navigator)
        viewController.presenter = presenter
        
        return viewController
    }
}
