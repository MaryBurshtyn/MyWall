//
//  SceneFactory+ShopList.swift
//  MyWall

import Foundation
import UIKit

extension SceneFactory {
    static func makeShopListModule(navigator: SceneNavigatorProtocol, dataManagerService: DataManagerServiceProtocol, appearenceConfig: AppearanceConfigProtocol) -> ShopListViewController {
        let viewController: ShopListViewController = ShopListViewController.storyboardInstance()
        let presenter = ShopListPresenter(view: viewController,
                                        navigator: navigator,
                                        dataManagerService: dataManagerService)
        viewController.presenter = presenter
        viewController.appearanceConfig = appearenceConfig
        return viewController
    }
}
