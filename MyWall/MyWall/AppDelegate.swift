//
//  AppDelegate.swift
//  MyWall
//
//  Created by Burshtyn, Mariya on 12.02.2020.
//  Copyright © 2020 Burshtyn, Mariya. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import SwiftyBeaver

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var compositionRoot: CompositionRoot!
    private var applicationFlow: ApplicationFlow!
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let console = ConsoleDestination()
        log.addDestination(console)
        setupFirebase()
        compositionRoot = makeCompositionRoot()
        applicationFlow = ApplicationFlow(compositionRoot: compositionRoot)
        applicationFlow.start(transitionType: .root)
        compositionRoot.getAppearanceConfig().setup()
        
        setupKeyboardManager()
        return true
    }
    
    private func setupFirebase() {
        FirebaseApp.configure()
    }
    
    private func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        
    }


}

