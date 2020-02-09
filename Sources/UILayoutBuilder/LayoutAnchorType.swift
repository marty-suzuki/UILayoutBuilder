//
//  LayoutAnchorType.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/07.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public protocol LayoutAnchorType {
    func constraint(equalTo anchor: Self) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self) -> NSLayoutConstraint
}

extension NSLayoutAnchor: LayoutAnchorType {}
