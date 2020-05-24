//
//  CurrencyServiceProtocol.swift
//  MyWall
//
//  Created by Burshtyn, Mariya on 23.05.2020.
//  Copyright © 2020 Burshtyn, Mariya. All rights reserved.
//

import Foundation
protocol CurrencyServiceProtocol {
    func makeRequest()
    func getBynRate() -> Float?
    func getUsdRate() -> Float?
    func getUahRate() -> Float?
    func getRubRate() -> Float?
    func convert(from: Currency, to: Currency, value: Float) -> Float
}
