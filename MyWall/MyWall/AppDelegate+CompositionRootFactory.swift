//
//  AppDelegate+CompositionRootFactory.swift
//  MyWall
//
//  Created by Burshtyn, Mariya on 02.04.2020.
//  Copyright © 2020 Burshtyn, Mariya. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

extension AppDelegate {
    func makeCompositionRoot() -> CompositionRoot {
        //let api = FirestoreApi()
        let factory = ServiceFactory(//api: api,
                                     userDafaults: UserDefaults.standard,
                                     bundle: Bundle.main)
        return CompositionRoot(serviceFactory: factory)
    }
}
