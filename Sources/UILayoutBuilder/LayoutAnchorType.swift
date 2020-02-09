//
//  LayoutAnchorType.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/07.
//

import UIKit

public protocol LayoutAnchorType {
    func constraint(equalTo anchor: Self) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self) -> NSLayoutConstraint
}

extension NSLayoutAnchor: LayoutAnchorType {}
