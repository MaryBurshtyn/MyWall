import Foundation
import UIKit

extension SceneFactory {
    static func makeCostModule(navigator: SceneNavigatorProtocol) -> CostViewController {
        let viewController: CostViewController = CostViewController.storyboardInstance()
        let presenter = CostPresenter(view: viewController,
                                        navigator: navigator)
        viewController.presenter = presenter
        
        return viewController
    }
}
