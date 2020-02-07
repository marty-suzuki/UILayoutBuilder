//
//  LayoutSize.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/07.
//

import UIKit

public struct LayoutSize {

    public var equalTo: Relation {
        .init(width: width.equalTo, height: height.equalTo)
    }

    private let width: LayoutDimension
    private let height: LayoutDimension

    init(width: LayoutDimension, height: LayoutDimension) {
        self.width = width
        self.height = height
    }

    public struct Relation {

        fileprivate let width: LayoutDimension.Relation
        fileprivate let height: LayoutDimension.Relation

        public func view(_ view: ViewProxy) -> ToSize {
            .init(width: width.anchor(view.width), height: height.anchor(view.height))
        }

        public func view(_ view: ViewProxy) -> ConstraintsBuilder {
            { [width, height] in
                [
                    width.anchor(view.width)(),
                    height.anchor(view.height)()
                ]
            }
        }

        public func size(width: CGFloat, height: CGFloat) -> ConstraintsBuilder {
            return { [w = self.width, h = self.height] in
                [
                    w.constant(width)(),
                    h.constant(height)()
                ]
            }
        }
    }

    public struct ToSize {

        fileprivate let width: LayoutDimension.ToAnchor
        fileprivate let height: LayoutDimension.ToAnchor

        public func size(width: CGFloat, height: CGFloat) -> ConstraintsBuilder {
            { [w = self.width, h = self.height] in
                [
                    w.constant(width)(),
                    h.constant(height)()
                ]
            }
        }

        public func multiplier(_ multiplier: CGFloat) -> ConstraintsBuilder {
            { [width, height] in
                [
                    width.multiplier(multiplier)(),
                    height.multiplier(multiplier)()
                ]
            }
        }
    }
}
