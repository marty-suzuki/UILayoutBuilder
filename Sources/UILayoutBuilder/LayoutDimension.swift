//
//  LayoutDimension.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/05.
//

import UIKit

public struct LayoutDimension {
    typealias RawAnchor = NSLayoutDimension

    private let rawAnchor: RawAnchor
    private let context: Context

    init(_ view: UIView, for keyPath: KeyPath<UIView, RawAnchor>, context: Context) {
        self.rawAnchor = view[keyPath: keyPath]
        self.context = context
    }
}

extension LayoutDimension {

    public var equalTo: Relation {
        .init(toAnchor: { [rawAnchor] in rawAnchor.constraint(equalTo: $0, multiplier: $1, constant: $2) },
              toConstant: { [rawAnchor] in rawAnchor.constraint(equalToConstant: $0) },
              context: context)
    }

    public var greaterThanOrEqualTo: Relation {
        .init(toAnchor: { [rawAnchor] in rawAnchor.constraint(greaterThanOrEqualTo: $0, multiplier: $1, constant: $2) },
              toConstant: { [rawAnchor] in rawAnchor.constraint(greaterThanOrEqualToConstant: $0) },
              context: context)
    }

    public var lessThanOrEqualTo: Relation {
        .init(toAnchor: { [rawAnchor] in rawAnchor.constraint(lessThanOrEqualTo: $0, multiplier: $1, constant: $2) },
              toConstant: { [rawAnchor] in rawAnchor.constraint(lessThanOrEqualToConstant: $0) },
              context: context)
    }
}

extension LayoutDimension {

    public struct Relation {
        fileprivate let toAnchor: (RawAnchor, CGFloat, CGFloat) -> NSLayoutConstraint
        fileprivate let toConstant: (CGFloat) -> NSLayoutConstraint
        fileprivate let context: Context
    }
}

extension LayoutDimension.Relation {

    @discardableResult
    public func constant(_ constant: CGFloat) -> NSLayoutConstraint {
        context.addConstraint(toConstant(constant))
    }

    @discardableResult
    public func anchor(_ anchor: LayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
        context.addConstraint(toAnchor(anchor.rawAnchor, multiplier, constant))
    }
}

