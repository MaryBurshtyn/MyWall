import UIKit

extension SceneFactory {
    static func makeHomeModule(navigator: SceneNavigatorProtocol) -> HomeViewController {
        let viewController: HomeViewController = HomeViewController.storyboardInstance()
        let presenter = HomePresenter(view: viewController,
                                        navigator: navigator)
        viewController.presenter = presenter
        
        return viewController
    }
}
