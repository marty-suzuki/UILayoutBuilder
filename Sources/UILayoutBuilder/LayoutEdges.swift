//
//  LayoutEdges.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/07.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public struct LayoutEdges {
    private let top: LayoutYAxis
    private let leading: LayoutXAxis
    private let bottom: LayoutYAxis
    private let trailing: LayoutXAxis

    init(top: LayoutYAxis, leading: LayoutXAxis, bottom: LayoutYAxis, trailing: LayoutXAxis) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }
}

extension LayoutEdges {

    public var equalTo: Relation {
        .init(top: top.equalTo,
              leading: leading.equalTo,
              bottom: bottom.equalTo,
              trailing: trailing.equalTo)
    }

    public var greaterThanOrEqualTo: Relation {
        .init(top: top.greaterThanOrEqualTo,
              leading: leading.greaterThanOrEqualTo,
              bottom: bottom.greaterThanOrEqualTo,
              trailing: trailing.greaterThanOrEqualTo)
    }

    public var lessThanOrEqualTo: Relation {
        .init(top: top.lessThanOrEqualTo,
              leading: leading.lessThanOrEqualTo,
              bottom: bottom.lessThanOrEqualTo,
              trailing: trailing.lessThanOrEqualTo)
    }
}

extension LayoutEdges {
    fileprivate typealias _Builder = UILayoutBuilder.Builder

    public struct Relation {
        fileprivate let top: LayoutYAxis.Relation
        fileprivate let leading: LayoutXAxis.Relation
        fileprivate let bottom: LayoutYAxis.Relation
        fileprivate let trailing: LayoutXAxis.Relation
    }

    public struct Builder {
        private let top: _Builder
        private let leading: _Builder
        private let bottom: _Builder
        private let trailing: _Builder

        fileprivate init(top: _Builder,
                         leading: _Builder,
                         bottom: _Builder,
                         trailing: _Builder) {
            self.top = top
            self.leading = leading
            self.bottom = bottom
            self.trailing = trailing
        }
    }

    public struct ConstrantGroup {
        public let top: NSLayoutConstraint
        public let leading: NSLayoutConstraint
        public let bottom: NSLayoutConstraint
        public let trailing: NSLayoutConstraint
    }
}

extension LayoutEdges.Relation {

    @discardableResult
    public func edges(_ layout: LayoutRepresentable) -> LayoutEdges.Builder {
        .init(top: top.top(layout),
              leading: leading.leading(layout),
              bottom: bottom.bottom(layout),
              trailing: trailing.trailing(layout))
    }
}

extension LayoutEdges.Builder {

    @discardableResult
    public func constant(_ constant: CGFloat) -> LayoutEdges.Builder {
        top.constant(constant)
        leading.constant(constant)
        bottom.constant(-constant)
        trailing.constant(-constant)
        return self
    }

    public func constant(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> LayoutEdges.Builder {
        self.top.constant(top)
        self.leading.constant(leading)
        self.bottom.constant(bottom)
        self.trailing.constant(trailing)
        return self
    }

    public func asConstraints() -> LayoutEdges.ConstrantGroup {
        .init(top: top.asConstraint(),
              leading: leading.asConstraint(),
              bottom: bottom.asConstraint(),
              trailing: trailing.asConstraint())
    }
}
