//
//  LayoutAxis.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/05.
//

import UIKit

public protocol LayoutAxisTrait {
    associatedtype RawAnchor: LayoutAnchorType
}

public enum Axis {

    public enum X: LayoutAxisTrait {
        public typealias RawAnchor = NSLayoutXAxisAnchor
    }

    public enum Y: LayoutAxisTrait {
        public typealias RawAnchor = NSLayoutYAxisAnchor
    }
}

public typealias LayoutYAxis = LayoutAxis<Axis.Y>
public typealias LayoutXAxis = LayoutAxis<Axis.X>

public struct LayoutAxis<Trait: LayoutAxisTrait> {
    typealias RawAnchor = Trait.RawAnchor

    private let rawAnchor: RawAnchor
    private let context: Context

    init(_ view: UIView, for keyPath: KeyPath<UIView, RawAnchor>, context: Context) {
        self.rawAnchor = view[keyPath: keyPath]
        self.context = context
    }
}

extension LayoutAxis {

    public var equalTo: Relation {
        .init(toAnchor: { [rawAnchor] in rawAnchor.constraint(equalTo: $0) },
              context: context)
    }

    public var greaterThanOrEqualTo: Relation {
        .init(toAnchor: { [rawAnchor] in rawAnchor.constraint(greaterThanOrEqualTo: $0) },
              context: context)
    }

    public var lessThanOrEqualTo: Relation {
        .init(toAnchor: { [rawAnchor] in rawAnchor.constraint(lessThanOrEqualTo: $0) },
              context: context)
    }
}

extension LayoutAxis {
    public typealias Builder = UILayoutBuilder.Builder

    public struct Relation {
        fileprivate let toAnchor: (RawAnchor) -> NSLayoutConstraint
        fileprivate let context: Context
    }
}

extension LayoutAxis.Relation {

    @discardableResult
    public func anchor(_ anchor: LayoutAxis<Trait>) -> LayoutAxis.Builder {
        .init(constraint: toAnchor(anchor.rawAnchor), context: context)
    }
}
