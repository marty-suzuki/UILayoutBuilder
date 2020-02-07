//
//  LayoutAnchorType.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/07.
//

import UIKit

public protocol LayoutAnchorType {
    func constraint(equalTo anchor: Self, constant c: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant c: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, constant c: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor: LayoutAnchorType {}
