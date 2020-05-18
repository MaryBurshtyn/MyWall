//
//  Graphics+SceneFactory.swift
//  MyWall
//
//  Created by Burshtyn, Mariya on 15.05.2020.
//  Copyright © 2020 Burshtyn, Mariya. All rights reserved.
//

import Foundation
import UIKit

extension SceneFactory {
    static func makeGraphicsModule(navigator: SceneNavigatorProtocol, appearenceConfig: AppearanceConfigProtocol, dataManager: DataManagerServiceProtocol) -> GraphicsViewController {
        let viewController: GraphicsViewController = GraphicsViewController.storyboardInstance()
        viewController.appearanceConfig = appearenceConfig
        let presenter = GraphicsPresenter(view: viewController,
                                        navigator: navigator, dataManagerService: dataManager)
        viewController.presenter = presenter
        
        return viewController
    }
}
