//
//  LoginViewProtocol.swift
//  MyWall
//
//  Created by Burshtyn, Mariya on 13.05.2020.
//  Copyright © 2020 Burshtyn, Mariya. All rights reserved.
//

import Foundation

protocol LoginViewProtocol: class {
    func handleViewDidLoad()
    func handleRegisterButtonTapped()
    func handleLoginButtonTapped()
    func showPreloader()
    func hidePreloader()
}
