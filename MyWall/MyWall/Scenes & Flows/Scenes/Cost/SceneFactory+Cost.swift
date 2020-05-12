import Foundation
import UIKit
import Reachability

extension SceneFactory {
    static func makeCostModule(navigator: SceneNavigatorProtocol, dataManagerService: DataManagerServiceProtocol, reachability: Reachability?) -> CostViewController {
        let viewController: CostViewController = CostViewController.storyboardInstance()
        let presenter = CostPresenter(view: viewController,
                                        navigator: navigator,
                                        dataManagerService: dataManagerService, reachability: reachability)
        viewController.presenter = presenter
        
        return viewController
    }
}
