//
//  ApplicationFlow.swift
//  OnlineCheckInApp
//
//  Created on 06/06/2019

import UIKit
import Foundation

class ApplicationFlow: FlowProtocol, ApplicationFlowNavigatorProtocol {
    private let navigator: SceneNavigatorFlowProtocol
    private let compositionRoot: CompositionRoot
    private let userDefaultsService: UserDefaultsServiceProtocol
    private let flowRouter: ApplicationFlowRouter
    
    private var isTokenRefreshing = false
    
    init(compositionRoot: CompositionRoot) {
        self.compositionRoot = compositionRoot
        self.navigator = SceneNavigator(window: UIWindow(frame: UIScreen.main.bounds), compositionRoot: compositionRoot)
        self.compositionRoot.navigator = navigator
        self.flowRouter = ApplicationFlowRouter(navigator: navigator)
        self.userDefaultsService = compositionRoot.getUserDefaultsService()
        navigator.flowNavigator = self
        navigator.initViewControllerHierarchy(withRootScene: .splash)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleApplicationWillEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.willEnterForegroundNotification,
                                                  object: nil)
        
    }
    
    func start(transitionType: SceneTransitionType) {
        let launchFlowCoordinator = makeLaunchFlow()
        flowRouter.start(flow: launchFlowCoordinator, transitionType: transitionType)
    }
    
    // MARK: - Notifications Handling
    
    @objc
    func handleApplicationWillEnterForeground(_ notification: NSNotification) {
//        if navigator.currentViewController is LoginViewController || isTokenRefreshing {
//            return
//        }
//        isTokenRefreshing = true
//
//        sessionService.refreshSignInState { [weak self] (result) in
//            guard let strongSelf = self else {
//                return
//            }
//            strongSelf.isTokenRefreshing = false
//            switch result {
//            case .success:
//                break
//            case .failure:
//                if strongSelf.navigator.currentViewController is LoginViewController {
//                    return
//                }
//                if strongSelf.userDefaultsService.isNotFirstLaunchApplication() {
//                    strongSelf.navigator.navigateTo(.login(delegate: strongSelf), transitionType: .modal)
//                }
//            }
//        }
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

// MARK: - LoginSceneDelegate
//
//extension ApplicationFlow: LoginSceneDelegate {
//    func handleSignIn() {
//        if flowRouter.isFlowRunning(MainFlow.self) {
//            navigator.returnToPreviousScene(animated: true)
//        } else {
//            let mainFlow = makeMainFlow()
//            flowRouter.start(flow: mainFlow, transitionType: .root)
//            setupObservers()
//            compositionRoot.startServices()
//        }
//    }
//}

