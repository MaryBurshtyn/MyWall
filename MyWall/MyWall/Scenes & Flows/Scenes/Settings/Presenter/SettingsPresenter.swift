//
//  SettingsPresenter.swift
//  MyWall
//
//  Created by Burshtyn, Mariya on 15.05.2020.
//  Copyright © 2020 Burshtyn, Mariya. All rights reserved.
//

import Foundation
class SettingsPresenter {

    unowned var view: SettingsViewProtocol
    unowned var navigator: SceneNavigatorProtocol
    unowned var api: ApiProtocol
    
    init(view: SettingsViewProtocol,
         navigator: SceneNavigatorProtocol,
         api: ApiProtocol) {
        
        self.view = view
        self.navigator = navigator
        self.api = api
    }
}

// MARK: - SplashPresenterProtocol

extension SettingsPresenter: SettingsPresenterProtocol {
    func handleViewDidLoad() {
        guard let email = api.getEmail() else {
            return
        }
        view.setEmail(email)
    }
    
    func handleLogOutTapped() {
        api.signOut()
        navigator.flowNavigator.navigateToLogin(transitionType: .root)
    }
    

}
