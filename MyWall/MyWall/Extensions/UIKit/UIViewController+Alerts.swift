//
//  UIViewController+Actions.swift
//  OnlineCheckInApp
//
//  Created on 25/02/2019.
//

import UIKit

extension UIViewController {

    func showErrorWithRetryAlert(title: String, onRetryTapped handleRetryTapped: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = title
        
        let retryTitle = R.string.localizable.commonRetry()
        
        alert.addAction(UIAlertAction(title: retryTitle, style: .default, handler: { _ in
            handleRetryTapped()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func showErrorWithRetryAlert(title: String,
                                 message: String,
                                 onRetryTapped handleRetryTapped: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = message
        
        let retryTitle = R.string.localizable.commonRetry()
        
        alert.addAction(UIAlertAction(title: retryTitle, style: .default, handler: { _ in
            handleRetryTapped()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func showOKAlertWithTapHandler(title: String,
                                   onOK handleOKTapped: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = title
        
        let okTitle = R.string.localizable.commonOk()
        
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { _ in
            handleOKTapped()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func showOKAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = title

        let title = R.string.localizable.commonOk()
        alert.addAction(UIAlertAction(title: title, style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }

    func showNoYesAlert(title: String, message: String, onNo: (() -> Void)? = nil, onYes: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = message

        let noTitle = R.string.localizable.commonNo()
        let yesTitle = R.string.localizable.commonYes()

        alert.addAction(UIAlertAction(title: noTitle, style: .default, handler: { _ in
            onNo?()
        }))

        alert.addAction(UIAlertAction(title: yesTitle, style: .default, handler: { _ in
            onYes()
        }))

        present(alert, animated: true, completion: nil)
    }

    func showOkCancelAlert(title: String, message: String, onOk: (() -> Void)?, onCancel: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = message
        
        let okTitle = R.string.localizable.commonOk()
        let cancelTitle = R.string.localizable.commonCancel()
        
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { _ in
            onOk?()
        }))
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .default, handler: { _ in
            onCancel?()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func showCancelConfirmAlert(title: String? = nil, message: String,
                                onCancel: (() -> Void)? = nil, onConfirm: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = message
        
        let cancelTitle = R.string.localizable.commonCancel()
        let confirmTitle = R.string.localizable.commonConfirm()
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .default, handler: { _ in
            onCancel?()
        }))
        
        alert.addAction(UIAlertAction(title: confirmTitle, style: .default, handler: { _ in
            onConfirm?()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func showForbidAllowAlert(title: String? = nil, message: String,
                              onForbid: (() -> Void)? = nil, onAllow: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = message
        
        let forbidTitle = R.string.localizable.commonForbid()
        let allowTitle = R.string.localizable.commonAllow()
        
        alert.addAction(UIAlertAction(title: forbidTitle, style: .default, handler: { _ in
            onForbid?()
        }))
        
        alert.addAction(UIAlertAction(title: allowTitle, style: .default, handler: { _ in
            onAllow?()
        }))
        
        present(alert, animated: true, completion: nil)
    }
}
