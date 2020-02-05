//
//  LayoutXAxis.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/05.
//

import UIKit

public struct LayoutXAxis {
    public typealias RawAnchor = NSLayoutXAxisAnchor

    public var equalTo: Relation {
        .init(toAnchor: { [rawAnchor] in rawAnchor.constraint(equalTo: $0, constant: $1) })
    }

    public var greaterThanOrEqualTo: Relation {
        .init(toAnchor: { [rawAnchor] in rawAnchor.constraint(greaterThanOrEqualTo: $0, constant: $1) })
    }

    public var lessThanOrEqualTo: Relation {
        .init(toAnchor: { [rawAnchor] in rawAnchor.constraint(lessThanOrEqualTo: $0, constant: $1) })
    }

    private let rawAnchor: RawAnchor

    init(_ view: UIView, for keyPath: KeyPath<UIView, RawAnchor>) {
        self.rawAnchor = view[keyPath: keyPath]
    }

    public struct Relation {
        fileprivate let toAnchor: (RawAnchor, CGFloat) -> NSLayoutConstraint

        public func anchor(_ anchor: LayoutXAxis) -> ToAnchor {
            .init(constraint: { [toAnchor] in toAnchor(anchor.rawAnchor, $0) })
        }

        public func anchor(_ anchor: LayoutXAxis) -> NSLayoutConstraint {
            { [toAnchor] in toAnchor(anchor.rawAnchor, 0) }()
        }
    }

    public struct ToAnchor {
        fileprivate let constraint: (CGFloat) -> NSLayoutConstraint

        public func constant(_ constant: CGFloat) -> NSLayoutConstraint {
            { [constraint] in constraint(constant) }()
        }
    }
}
