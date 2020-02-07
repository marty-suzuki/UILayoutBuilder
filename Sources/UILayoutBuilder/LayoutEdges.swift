//
//  LayoutEdges.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/07.
//

import UIKit

public struct LayoutEdges {

    public var equalTo: Relation {
        .init(toTopAnchor: { [to  = top] from, constant in to.equalTo.anchor(from).constant(constant)() },
              toLeadingAnchor: { [to  = leading] from, constant in to.equalTo.anchor(from).constant(constant)() },
              toBottomAnchor: { [to  = bottom] from, constant in to.equalTo.anchor(from).constant(constant)() },
              toTrailingAnchor: { [to  = trailing] from, constant in to.equalTo.anchor(from).constant(constant)() })
    }

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

    public struct Relation {

        fileprivate let toTopAnchor: (LayoutYAxis, CGFloat) -> NSLayoutConstraint
        fileprivate let toLeadingAnchor: (LayoutXAxis, CGFloat) -> NSLayoutConstraint
        fileprivate let toBottomAnchor: (LayoutYAxis, CGFloat) -> NSLayoutConstraint
        fileprivate let toTrailingAnchor: (LayoutXAxis, CGFloat) -> NSLayoutConstraint

        public func view(_ view: ViewProxy) -> ToInsets {
            .init { [edges = view.edges, toTopAnchor, toLeadingAnchor, toBottomAnchor, toTrailingAnchor] insets in
                [
                    toTopAnchor(edges.top, insets.top),
                    toLeadingAnchor(edges.leading, insets.leading),
                    toBottomAnchor(edges.bottom, insets.bottom),
                    toTrailingAnchor(edges.trailing, insets.trailing)
                ]
            }
        }

        public func view(_ view: ViewProxy) -> ConstraintsBuilder {
            { [edges = view.edges, toTopAnchor, toLeadingAnchor, toBottomAnchor, toTrailingAnchor] in
                [
                    toTopAnchor(edges.top, 0),
                    toLeadingAnchor(edges.leading, 0),
                    toBottomAnchor(edges.bottom, 0),
                    toTrailingAnchor(edges.trailing, 0)
                ]
            }
        }
    }

    public struct ToInsets {
        let constraints: ((top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat)) -> [NSLayoutConstraint]

        public func insets(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> ConstraintsBuilder {
            { [constraints] in constraints((top, leading, bottom, trailing)) }
        }

        public func insets(_ all: CGFloat) -> ConstraintsBuilder {
            { [constraints] in constraints((all, all, -all, -all)) }
        }
    }
}
