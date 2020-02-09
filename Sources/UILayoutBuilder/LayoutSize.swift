//
//  LayoutSize.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/07.
//

import UIKit

public struct LayoutSize {

    private let width: LayoutDimension
    private let height: LayoutDimension

    init(width: LayoutDimension, height: LayoutDimension) {
        self.width = width
        self.height = height
    }
}

extension LayoutSize {

    public var equalTo: Relation {
        .init(width: width.equalTo, height: height.equalTo)
    }
}

extension LayoutSize {
    fileprivate typealias _Builder = UILayoutBuilder.Builder

    public struct Relation {
        fileprivate let width: LayoutDimension.Relation
        fileprivate let height: LayoutDimension.Relation
    }

    public final class Builder {
        private let width: _Builder
        private let height: _Builder

        fileprivate init(width: _Builder, height: _Builder) {
            self.width = width
            self.height = height
        }
    }

    public struct ConstrantGroup {
        public let width: NSLayoutConstraint
        public let height: NSLayoutConstraint
    }
}

extension LayoutSize.Relation {

    @discardableResult
    public func size(_ view: ViewProxy) -> LayoutSize.Builder {
        .init(width: width.anchor(view.width), height: height.anchor(view.height))
    }

    @discardableResult
    public func constant(width: CGFloat, height: CGFloat) -> LayoutSize.Builder {
        .init(width: self.width.constant(width), height: self.height.constant(height))
    }
}

extension LayoutSize.Builder {

    @discardableResult
    public func constant(width: CGFloat, height: CGFloat) -> LayoutSize.Builder {
        self.width.constant(width)
        self.height.constant(height)
        return self
    }

    @discardableResult
    public func priority(width: UILayoutPriority, height: UILayoutPriority) -> LayoutSize.Builder {
        self.width.priority(width)
        self.height.priority(height)
        return self
    }

    @discardableResult
    public func multiplier(width: CGFloat, height: CGFloat) -> LayoutSize.Builder {
        self.width.multiplier(width)
        self.height.multiplier(height)
        return self
    }


    public func asConstraints() -> LayoutSize.ConstrantGroup {
        .init(width: width.asConstraint(),
              height: height.asConstraint())
    }
}
