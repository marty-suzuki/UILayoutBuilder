//
//  LayoutEdges.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/07.
//

import UIKit

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
        .init(toTopAnchor:      { [to = top]      from in to.equalTo.anchor(from) },
              toLeadingAnchor:  { [to = leading]  from in to.equalTo.anchor(from) },
              toBottomAnchor:   { [to = bottom]   from in to.equalTo.anchor(from) },
              toTrailingAnchor: { [to = trailing] from in to.equalTo.anchor(from) })
    }

    public var greaterThanOrEqualTo: Relation {
        .init(toTopAnchor:      { [to = top]      from in to.greaterThanOrEqualTo.anchor(from) },
              toLeadingAnchor:  { [to = leading]  from in to.greaterThanOrEqualTo.anchor(from) },
              toBottomAnchor:   { [to = bottom]   from in to.greaterThanOrEqualTo.anchor(from) },
              toTrailingAnchor: { [to = trailing] from in to.greaterThanOrEqualTo.anchor(from) })
    }

    public var lessThanOrEqualTo: Relation {
        .init(toTopAnchor:      { [to = top]      from in to.lessThanOrEqualTo.anchor(from) },
              toLeadingAnchor:  { [to = leading]  from in to.lessThanOrEqualTo.anchor(from) },
              toBottomAnchor:   { [to = bottom]   from in to.lessThanOrEqualTo.anchor(from) },
              toTrailingAnchor: { [to = trailing] from in to.lessThanOrEqualTo.anchor(from) })
    }
}

extension LayoutEdges {
    fileprivate typealias _Builder = UILayoutBuilder.Builder

    public struct Relation {
        fileprivate let toTopAnchor: (LayoutYAxis) -> _Builder
        fileprivate let toLeadingAnchor: (LayoutXAxis) -> _Builder
        fileprivate let toBottomAnchor: (LayoutYAxis) -> _Builder
        fileprivate let toTrailingAnchor: (LayoutXAxis) -> _Builder
    }

    public final class Builder {
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
    public func edges(_ view: ViewProxy) -> LayoutEdges.Builder {
        let edges = view.edges
        return .init(top: toTopAnchor(edges.top),
                     leading: toLeadingAnchor(edges.leading),
                     bottom: toBottomAnchor(edges.bottom),
                     trailing: toTrailingAnchor(edges.trailing))
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
