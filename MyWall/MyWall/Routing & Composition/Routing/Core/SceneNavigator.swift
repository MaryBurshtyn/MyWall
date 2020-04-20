import UIKit

protocol ApplicationFlowNavigatorProtocol: AnyObject {
    func navigateToLogin(transitionType: SceneTransitionType)
    
    func removeRunningFlows()
}

class SceneNavigator: SceneNavigatorFlowProtocol {
        
    private let compositionRoot: CompositionRoot
    private unowned var applicationFlowNavigator: ApplicationFlowNavigatorProtocol!
    private let window: UIWindow
    var currentViewController: UIViewController!

    var flowNavigator: ApplicationFlowNavigatorProtocol {
        set {
            guard applicationFlowNavigator == nil else {
                fatalError("flowNavigator can be set only once -- during assembling \(self)")
            }
            applicationFlowNavigator = newValue
        }
        get {
            return applicationFlowNavigator
        }
    }
    
    required init(window: UIWindow, compositionRoot: CompositionRoot) {
        self.compositionRoot = compositionRoot
        self.window = window
    }
    
    // TODO: ensure method is called only once
    func initViewControllerHierarchy(withRootScene rootScene: Scene) {
        let viewController = compositionRoot.composeScene(rootScene)
        currentViewController = actualViewController(for: viewController)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    private func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            guard let firstViewController = navigationController.viewControllers.first else {
                fatalError("NavigationController is expected to have at least one View Controller")
            }
            return firstViewController
        } else {
            return viewController
        }
    }
    
    // MARK: - Navigate To Next Scene
    
    func navigateTo(_ scene: Scene, transitionType: SceneTransitionType) {
        let viewController = compositionRoot.composeScene(scene)
        
        switch transitionType {
        case .root:
            replaceRootWith(viewController)
        case .push:
            pushTo(viewController)
        case .modal:
            presentAsModal(viewController)
        case .popUp:
            presentAsPopUp(viewController)
        }
    }
    
    private func replaceRootWith(_ targetViewController: UIViewController) {
        currentViewController = actualViewController(for: targetViewController)
        window.set(rootViewController: targetViewController)
    }
    
    private func pushTo(_ targetViewController: UIViewController) {
        var currentController = currentViewController
        if let tabBarController = actualViewController(for: currentViewController) as? UITabBarController {
            currentController = tabBarController.selectedViewController
        }
        
        if let navigationController = currentController?.navigationController {
            currentController = navigationController
        }
        guard let navigationController = currentController as? UINavigationController else {
            fatalError("Can't push a view controller without a current navigation controller")
        }
        
        navigationController.pushViewController(targetViewController, animated: true)
    }
    
    private func presentAsModal(_ targetViewController: UIViewController) {
        targetViewController.modalPresentationStyle = .fullScreen
        currentViewController.present(targetViewController, animated: true)
        currentViewController = actualViewController(for: targetViewController)
    }

    private func presentAsPopUp(_ targetViewController: UIViewController) {
        targetViewController.modalPresentationStyle = .overCurrentContext
        currentViewController.present(targetViewController, animated: true)
    }
    
    // MARK: - Return Back To Previous Scene
    
    func returnToPreviousScene(animated: Bool) {
        if let presentingViewController = currentViewController.presentingViewController {
            // dismiss a modal controller
            currentViewController.dismiss(animated: animated) {
                self.currentViewController = self.actualViewController(for: presentingViewController)
            }
        } else if let navigationController = currentViewController.navigationController {
            navigateUpTheStackIn(navigationController, animated: animated)
        } else if let tabBarController = currentViewController as? UITabBarController {
            // navigate up the stack in TabBar
            navigateUpTheStackIn(tabBarController, animated: animated)
        } else {
            let viewDesc = String(describing: currentViewController)
            fatalError("Not a modal, no navigation controller: can't navigate back from \(viewDesc))")
        }
    }
    
    private func navigateUpTheStackIn(_ navigationController: UINavigationController, animated: Bool) {
        guard navigationController.popViewController(animated: animated) != nil else {
            fatalError("can't navigate back from \(String(describing: currentViewController))")
        }
        guard let lastViewController = navigationController.viewControllers.last else {
            fatalError("NavigationController is expected to have at least one View Controller")
        }
        currentViewController = actualViewController(for: lastViewController)
    }
    
    private func navigateUpTheStackIn(_ tabBarController: UITabBarController, animated: Bool) {
        guard let navigationController = tabBarController.selectedViewController as? UINavigationController else {
            let selectedViewCOntrollerDescription = String(describing: tabBarController.selectedViewController)
            fatalError("no navigation controller: can't navigate back from \(selectedViewCOntrollerDescription)")
        }
        guard navigationController.popViewController(animated: animated) != nil else {
            fatalError("can't navigate back from \(String(describing: tabBarController.selectedViewController))")
        }
    }
}
