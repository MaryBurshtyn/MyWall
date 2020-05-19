import Foundation

class ApplicationFlowRouter {
    private let sceneNavigator: SceneNavigatorFlowProtocol
    
    private var currentFlow: FlowProtocol?
    private var runningFlows: [FlowProtocol] = []

    init(navigator: SceneNavigatorFlowProtocol) {
        self.sceneNavigator = navigator
    }
    
    func start(flow: FlowProtocol, transitionType: SceneTransitionType) {
        if transitionType == .root {
            runningFlows.removeAll()
        }
        currentFlow = flow
        runningFlows.append(flow)
        flow.start(transitionType: transitionType)
    }
    
    func removeRunningFlows() {
        currentFlow = nil
        runningFlows.removeAll()
    }
    
    func isFlowRunning(_ flowClass: FlowProtocol.Type) -> Bool {
        let flow = runningFlows.first(where: { type(of: $0) == flowClass })
        return flow != nil
    }
}
