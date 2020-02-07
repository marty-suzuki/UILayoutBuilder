//
//  LayoutSize.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/07.
//

import UIKit

public struct LayoutSize {

    private let width: LayoutDimension
    private let height: LayoutDimension

    init(width: LayoutDimension, height: LayoutDimension) {
        self.width = width
        self.height = height
    }
}

extension LayoutSize {

    public var equalTo: Relation {
        .init(width: width.equalTo, height: height.equalTo)
    }
}

extension LayoutSize {
    public struct Relation {
        fileprivate let width: LayoutDimension.Relation
        fileprivate let height: LayoutDimension.Relation
    }
}

extension LayoutSize.Relation {

    @discardableResult
    public func view(_ view: ViewProxy,
                     multiplier: CGFloat = 1,
                     width: CGFloat = 0,
                     height: CGFloat = 0) -> [NSLayoutConstraint] {
        [
            self.width.anchor(view.width, multiplier: multiplier, constant: width),
            self.height.anchor(view.height, multiplier: multiplier, constant: height)
        ]
    }

    @discardableResult
    public func size(width: CGFloat, height: CGFloat) -> [NSLayoutConstraint] {
        [
            self.width.constant(width),
            self.height.constant(height)
        ]
    }
}
