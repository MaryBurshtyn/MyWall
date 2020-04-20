//
//  SceneCoordinatorProtocol.swift
//  TestBeforeKB
//
//  Created on 20.02.19.
//

import UIKit

protocol SceneNavigatorProtocol: class {

    var flowNavigator: ApplicationFlowNavigatorProtocol { get set }

    func initViewControllerHierarchy(withRootScene rootScene: Scene)
    func navigateTo(_ scene: Scene, transitionType: SceneTransitionType)
    func returnToPreviousScene(animated: Bool)
}

protocol SceneNavigatorFlowProtocol: SceneNavigatorProtocol {
    var currentViewController: UIViewController! { get }
}
