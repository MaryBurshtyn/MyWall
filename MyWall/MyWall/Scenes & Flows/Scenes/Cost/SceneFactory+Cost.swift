import Foundation
import UIKit
import Reachability

extension SceneFactory {
    static func makeCostModule(navigator: SceneNavigatorProtocol, dataManagerService: DataManagerServiceProtocol, reachability: Reachability?, api: ApiProtocol, appearenceConfig: AppearanceConfigProtocol) -> CostViewController {
        let viewController: CostViewController = CostViewController.storyboardInstance()
        let presenter = CostPresenter(view: viewController,
                                        navigator: navigator,
                                        dataManagerService: dataManagerService, reachability: reachability, api: api)
        viewController.presenter = presenter
        viewController.appearanceConfig = appearenceConfig
        return viewController
    }
}
