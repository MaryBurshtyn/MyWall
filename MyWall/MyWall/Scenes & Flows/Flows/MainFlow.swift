import Foundation

protocol MainFlowDelegate: AnyObject {
}

class MainFlow: FlowProtocol {

    private unowned let navigator: SceneNavigatorProtocol
    private unowned let flowDelegate: MainFlowDelegate
    
    init(navigator: SceneNavigatorProtocol, flowDelegate: MainFlowDelegate) {
        self.navigator = navigator
        self.flowDelegate = flowDelegate
    }
    
    func start(transitionType: SceneTransitionType) {
       navigator.navigateTo(.tabBar, transitionType: transitionType)
    }
}
