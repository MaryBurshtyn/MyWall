import Foundation
import UIKit

extension SceneFactory {
    static func makeIncomeModule(navigator: SceneNavigatorProtocol) -> IncomeViewController {
        let viewController: IncomeViewController = IncomeViewController.storyboardInstance()
        let presenter = IncomePresenter(view: viewController,
                                        navigator: navigator)
        viewController.presenter = presenter
        
        return viewController
    }
}
