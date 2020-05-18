import Foundation
import UIKit
import Reachability

extension SceneFactory {
    static func makeIncomeModule(navigator: SceneNavigatorProtocol,  dataManagerService: DataManagerServiceProtocol, reachability: Reachability?, api: ApiProtocol, appearenceConfig: AppearanceConfigProtocol) -> IncomeViewController {
        let viewController: IncomeViewController = IncomeViewController.storyboardInstance()
        let presenter = IncomePresenter(view: viewController,
                                        navigator: navigator, dataManagerService: dataManagerService, reachability: reachability, api: api)
        viewController.presenter = presenter
        viewController.appearanceConfig = appearenceConfig
        return viewController
    }
}
