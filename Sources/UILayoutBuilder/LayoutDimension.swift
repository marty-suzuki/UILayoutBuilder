//
//  LayoutDimension.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/05.
//

import UIKit

public struct LayoutDimension {
    public typealias RawAnchor = NSLayoutDimension

    public var equalTo: Relation {
        .init(toAnchor: { [rawAnchor] in rawAnchor.constraint(equalTo: $0, multiplier: $1, constant: $2) },
              toConstant: { [rawAnchor] in rawAnchor.constraint(equalToConstant: $0) })
    }

    public var greaterThanOrEqualTo: Relation {
        .init(toAnchor: { [rawAnchor] in rawAnchor.constraint(greaterThanOrEqualTo: $0, multiplier: $1, constant: $2) },
              toConstant: { [rawAnchor] in rawAnchor.constraint(greaterThanOrEqualToConstant: $0) })
    }

    public var lessThanOrEqualTo: Relation {
        .init(toAnchor: { [rawAnchor] in rawAnchor.constraint(lessThanOrEqualTo: $0, multiplier: $1, constant: $2) },
              toConstant: { [rawAnchor] in rawAnchor.constraint(lessThanOrEqualToConstant: $0) })
    }

    private let rawAnchor: RawAnchor

    init(_ view: UIView, for keyPath: KeyPath<UIView, RawAnchor>) {
        self.rawAnchor = view[keyPath: keyPath]
    }

    public struct Relation {
        fileprivate let toAnchor: (RawAnchor, CGFloat, CGFloat) -> NSLayoutConstraint
        fileprivate let toConstant: (CGFloat) -> NSLayoutConstraint

        public func constant(_ constant: CGFloat) -> ConstraintBuilder {
            { [toConstant] in toConstant(constant) }
        }

        public func anchor(_ anchor: LayoutDimension) -> ToAnchor {
            .init(constraint: { [toAnchor] in toAnchor(anchor.rawAnchor, $0, $1) })
        }

        public func anchor(_ anchor: LayoutDimension) -> ConstraintBuilder {
            { [toAnchor] in toAnchor(anchor.rawAnchor, 1, 0) }
        }
    }

    public struct ToAnchor {
        fileprivate let constraint: (CGFloat, CGFloat) -> NSLayoutConstraint

        public func constant(_ constant: CGFloat) -> Multiplier {
            .init(constraint: { [constraint] in constraint($0, constant) })
        }

        public func constant(_ constant: CGFloat) -> ConstraintBuilder {
            { [constraint] in constraint(1, constant) }
        }

        public func multiplier(_ multiplier: CGFloat) -> Constant {
            .init(constraint: { [constraint] in constraint(multiplier, $0) })
        }

        public func multiplier(_ multiplier: CGFloat) -> ConstraintBuilder {
            { [constraint] in constraint(multiplier, 0) }
        }
    }

    public struct Multiplier {
        fileprivate let constraint: (CGFloat) -> NSLayoutConstraint

        public func multiplier(_ multiplier: CGFloat) -> ConstraintBuilder {
            { [constraint] in constraint(multiplier) }
        }
    }

    public struct Constant {
        fileprivate let constraint: (CGFloat) -> NSLayoutConstraint

        public func constant(_ constant: CGFloat) -> ConstraintBuilder {
            { [constraint] in constraint(constant) }
        }
    }
}

