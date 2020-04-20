//
//  UIView+Constraints.swift
//  OnlineCheckInApp
//
//  Created on 27/02/2019

import UIKit

extension UIView {

    func constraintEdgesToParent(_ parent: UIView, topAnchorOffset: CGFloat = 0) {

        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: parent.topAnchor, constant: topAnchorOffset).isActive = true
        bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
    }

    func constraintCenterToParent(_ parent: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
    }
    
    func addFillSubview(_ subview: UIView, topAnchorOffset: CGFloat = 0) {
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        subview.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        subview.topAnchor.constraint(equalTo: topAnchor, constant: topAnchorOffset).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
