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
        .init(toTopAnchor:      { [to = top]      from, constant in to.equalTo.anchor(from, constant: constant) },
              toLeadingAnchor:  { [to = leading]  from, constant in to.equalTo.anchor(from, constant: constant) },
              toBottomAnchor:   { [to = bottom]   from, constant in to.equalTo.anchor(from, constant: constant) },
              toTrailingAnchor: { [to = trailing] from, constant in to.equalTo.anchor(from, constant: constant) })
    }

    public var greaterThanOrEqualTo: Relation {
        .init(toTopAnchor:      { [to = top]      from, constant in to.greaterThanOrEqualTo.anchor(from, constant: constant) },
              toLeadingAnchor:  { [to = leading]  from, constant in to.greaterThanOrEqualTo.anchor(from, constant: constant) },
              toBottomAnchor:   { [to = bottom]   from, constant in to.greaterThanOrEqualTo.anchor(from, constant: constant) },
              toTrailingAnchor: { [to = trailing] from, constant in to.greaterThanOrEqualTo.anchor(from, constant: constant) })
    }

    public var lessThanOrEqualTo: Relation {
        .init(toTopAnchor:      { [to = top]      from, constant in to.lessThanOrEqualTo.anchor(from, constant: constant) },
              toLeadingAnchor:  { [to = leading]  from, constant in to.lessThanOrEqualTo.anchor(from, constant: constant) },
              toBottomAnchor:   { [to = bottom]   from, constant in to.lessThanOrEqualTo.anchor(from, constant: constant) },
              toTrailingAnchor: { [to = trailing] from, constant in to.lessThanOrEqualTo.anchor(from, constant: constant) })
    }
}

extension LayoutEdges {

    public struct Relation {
        fileprivate let toTopAnchor: (LayoutYAxis, CGFloat) -> NSLayoutConstraint
        fileprivate let toLeadingAnchor: (LayoutXAxis, CGFloat) -> NSLayoutConstraint
        fileprivate let toBottomAnchor: (LayoutYAxis, CGFloat) -> NSLayoutConstraint
        fileprivate let toTrailingAnchor: (LayoutXAxis, CGFloat) -> NSLayoutConstraint
    }
}

extension LayoutEdges.Relation {

    @discardableResult
    public func view(_ view: ViewProxy,
                     top: CGFloat,
                     leading: CGFloat,
                     bottom: CGFloat,
                     trailing: CGFloat) -> [NSLayoutConstraint] {
        let edges = view.edges
        return [
            toTopAnchor(edges.top, top),
            toLeadingAnchor(edges.leading, leading),
            toBottomAnchor(edges.bottom, bottom),
            toTrailingAnchor(edges.trailing, trailing)
        ]
    }

    @discardableResult
    public func view(_ view: ViewProxy, all constant: CGFloat) -> [NSLayoutConstraint] {
        let edges = view.edges
        return [
            toTopAnchor(edges.top, constant),
            toLeadingAnchor(edges.leading, constant),
            toBottomAnchor(edges.bottom, -constant),
            toTrailingAnchor(edges.trailing, -constant)
        ]
    }
}
