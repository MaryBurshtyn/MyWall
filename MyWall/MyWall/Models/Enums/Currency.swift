//
//  Currency.swift
//  MyWall
//
//  Created by Burshtyn, Mariya on 12.05.2020.
//  Copyright © 2020 Burshtyn, Mariya. All rights reserved.
//

import Foundation

enum Currency: Int {
    case byn
    case rub
    case usd
    case grn
    case eur
    
    init(from stringValue: String) {
        switch stringValue {
        case L10n.bynCurrency:
            self = Currency.byn
        case L10n.rubCurrency:
            self = Currency.rub
        case L10n.usdCurrency:
            self = Currency.usd
        case L10n.grnCurrency:
            self = Currency.grn
        case L10n.eurCurrency:
            self = Currency.eur
        default:
            self = Currency.byn
        }
    }
    
    var stringValue: String {
        switch self {
        case .byn:
            return L10n.bynCurrency
        case .rub:
            return L10n.rubCurrency
        case .usd:
            return L10n.usdCurrency
        case .grn:
            return L10n.grnCurrency
        case .eur:
            return L10n.eurCurrency
        }
    }
    
    var rate: Float {
        switch self {
        case .byn:
            guard let stringValue = UserDefaults.standard.string(forKey: AppConstants.bynRate),
            let value = Float(stringValue) else {
                return 1.0
            }
            return value
        case .rub:
            guard let stringValue = UserDefaults.standard.string(forKey: AppConstants.rubRate),
            let value = Float(stringValue) else {
               return 1.0
            }
            return Float(value)
        case .usd:
            guard let stringValue = UserDefaults.standard.string(forKey: AppConstants.usdRate),
            let value = Float(stringValue) else {
              return 1.0
            }
            return Float(value)
        case .grn:
            guard let stringValue = UserDefaults.standard.string(forKey: AppConstants.uahRate),
            let value = Float(stringValue) else {
              return 1.0
            }
            return Float(value)
        case .eur:
              return 1.0
        }
    }
}
