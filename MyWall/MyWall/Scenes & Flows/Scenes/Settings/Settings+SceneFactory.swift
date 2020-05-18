import Foundation
import UIKit

extension SceneFactory {
    static func makeSettingsModule(navigator: SceneNavigatorProtocol, appearenceConfig: AppearanceConfigProtocol, api: ApiProtocol) -> SettingsViewController {
        let viewController: SettingsViewController = SettingsViewController.storyboardInstance()
        viewController.appearanceConfig = appearenceConfig
        let presenter = SettingsPresenter(view: viewController,
                                        navigator: navigator, api: api)
        viewController.presenter = presenter
        
        return viewController
    }
}
