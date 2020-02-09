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
    func anchor(_ anchor: LayoutAxis<Trait>) -> LayoutAxis.Builder {
        .init(constraint: toAnchor(anchor.rawAnchor), context: context)
    }
}

extension LayoutAxis.Relation where Trait == Axis.Y {

    @discardableResult
    public func top(_ view: ViewProxy) -> LayoutAxis.Builder {
        anchor(view.top)
    }

    @discardableResult
    public func bottom(_ view: ViewProxy) -> LayoutAxis.Builder {
        anchor(view.bottom)
    }

    @discardableResult
    public func centerY(_ view: ViewProxy) -> LayoutAxis.Builder {
        anchor(view.centerY)
    }

    @discardableResult
    public func firstBaseline(_ view: ViewProxy) -> LayoutAxis.Builder {
        anchor(view.firstBaseline)
    }

    @discardableResult
    public func lastBaseline(_ view: ViewProxy) -> LayoutAxis.Builder {
        anchor(view.lastBaseline)
    }
}

extension LayoutAxis.Relation where Trait == Axis.X {

    @discardableResult
    public func leading(_ view: ViewProxy) -> LayoutAxis.Builder {
        anchor(view.leading)
    }

    @discardableResult
    public func trailing(_ view: ViewProxy) -> LayoutAxis.Builder {
        anchor(view.trailing)
    }

    @discardableResult
    public func left(_ view: ViewProxy) -> LayoutAxis.Builder {
        anchor(view.left)
    }

    @discardableResult
    public func right(_ view: ViewProxy) -> LayoutAxis.Builder {
        anchor(view.right)
    }

    @discardableResult
    public func centerX(_ view: ViewProxy) -> LayoutAxis.Builder {
        anchor(view.centerX)
    }
}
