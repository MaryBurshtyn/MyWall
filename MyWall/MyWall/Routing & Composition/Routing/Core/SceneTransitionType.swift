//
//  SceneTransitionType.swift
//  TestBeforeKB
//
//  Created on 20.02.19.
//

import Foundation

enum SceneTransitionType {
    case root       // make view controller the root view controller
    case push       // push view controller to navigation stack
    case modal      // present view controller modally
    case popUp      // present view controller as pop-up
}
