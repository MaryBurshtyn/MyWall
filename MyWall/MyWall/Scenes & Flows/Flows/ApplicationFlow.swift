import UIKit
import Foundation

class ApplicationFlow: FlowProtocol, ApplicationFlowNavigatorProtocol {
    private let navigator: SceneNavigatorFlowProtocol
    private let compositionRoot: CompositionRoot
    private let flowRouter: ApplicationFlowRouter
    
    private var isTokenRefreshing = false
    
    init(compositionRoot: CompositionRoot) {
        self.compositionRoot = compositionRoot
        self.navigator = SceneNavigator(window: UIWindow(frame: UIScreen.main.bounds), compositionRoot: compositionRoot)
        self.compositionRoot.navigator = navigator
        self.flowRouter = ApplicationFlowRouter(navigator: navigator)
        navigator.flowNavigator = self
        navigator.initViewControllerHierarchy(withRootScene: .splash)
    }
    
    func start(transitionType: SceneTransitionType) {
        let launchFlowCoordinator = makeLaunchFlow()
        flowRouter.start(flow: launchFlowCoordinator, transitionType: transitionType)
    }
    
    // MARK: - ApplicationFlowNavigatorProtocol
    
    func navigateToLogin(transitionType: SceneTransitionType) {
        if transitionType == .root {
            removeRunningFlows()
        }
        
        navigator.navigateTo(.login, transitionType: .modal)
    }
    
    func removeRunningFlows() {
        flowRouter.removeRunningFlows()
    }
    
    // MARK: - MakeCoordinators
    
    private func makeLaunchFlow() -> LaunchFlow {
        return LaunchFlow(navigator: navigator,
                          flowDelegate: self)
    }
    
    private func makeMainFlow() -> MainFlow {
        return MainFlow(navigator: navigator, flowDelegate: self)
    }
    
    // MARK: - Setup Observers
}

// MARK: - FlowDelegate
// MARK: - LaunchFlowDelegate

extension ApplicationFlow: LaunchFlowDelegate {
    func handleFlowFinished() {
        compositionRoot.getFirebaseApiService().isSignedIn ?
            handleLaunchApplication()
            : compositionRoot.getFirebaseApiService().refresh(completion: { [weak self] result in
                switch result {
                case .success():
                    self?.handleLaunchApplication()
                case .failure(_):
                    self?.navigator.navigateTo(.login, transitionType: .root)
                }
            })
    }
    
    private func handleLaunchApplication() {
        let mainFlow = makeMainFlow()
        flowRouter.start(flow: mainFlow, transitionType: .root)
        compositionRoot.startServices()
    }
}

// MARK: - MainFlowDelegate

extension ApplicationFlow: MainFlowDelegate {
    
}

