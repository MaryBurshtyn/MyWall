import Foundation

protocol LaunchFlowDelegate: AnyObject {
    func handleFlowFinished()
}

class LaunchFlow: FlowProtocol {
    
    private unowned let navigator: SceneNavigatorProtocol
    private unowned let flowDelegate: LaunchFlowDelegate
    
    init(navigator: SceneNavigatorProtocol,
         flowDelegate: LaunchFlowDelegate) {
        self.navigator = navigator
        self.flowDelegate = flowDelegate
    }
    
    // MARK: - FlowCoordinatorProtocol
    
    func start(transitionType: SceneTransitionType) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.flowDelegate.handleFlowFinished()
            //self.navigator.navigateTo(.tabBar, transitionType: transitionType)
        }
    }
    
    // MARK: - Private
}

// MARK: - AcceptAgreementsSceneDelegate
