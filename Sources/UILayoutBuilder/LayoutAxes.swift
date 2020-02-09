//
//  LayoutAxes.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/07.
//

import UIKit

public typealias LayoutCenter = LayoutAxes<Axes.Center>
public typealias LayoutHorizontal = LayoutAxes<Axes.Horizontal>
public typealias LayoutVertical = LayoutAxes<Axes.Vertical>

public protocol LayoutAxiesTrait {
    associatedtype Axis1: LayoutAxisTrait
    associatedtype Axis2: LayoutAxisTrait
    static func axes(from view: ViewProxy) -> LayoutAxes<Self>
}

public enum Axes {

    public enum Horizontal: LayoutAxiesTrait {
        public typealias Axis1 = Axis.X
        public typealias Axis2 = Axis.X

        public static func axes(from view: ViewProxy) -> LayoutAxes<Horizontal> {
            view.horizontal
        }
    }

    public enum Vertical: LayoutAxiesTrait {
        public typealias Axis1 = Axis.Y
        public typealias Axis2 = Axis.Y

        public static func axes(from view: ViewProxy) -> LayoutAxes<Vertical> {
            view.vertical
        }
    }

    public enum Center: LayoutAxiesTrait {
        public typealias Axis1 = Axis.X
        public typealias Axis2 = Axis.Y

        public static func axes(from view: ViewProxy) -> LayoutAxes<Center> {
            view.center
        }
    }
}

public struct LayoutAxes<Trait: LayoutAxiesTrait> {
    typealias Axis1 = Trait.Axis1
    typealias Axis2 = Trait.Axis2

    private let axis1: LayoutAxis<Axis1>
    private let axis2: LayoutAxis<Axis2>

    init(axis1: LayoutAxis<Axis1>, axis2: LayoutAxis<Axis2>) {
        self.axis1 = axis1
        self.axis2 = axis2
    }
}

extension LayoutAxes {

    public var equalTo: Relation {
        .init(axis1: axis1.equalTo, axis2: axis2.equalTo)
    }
}

extension LayoutAxes {
    fileprivate typealias _Builder = UILayoutBuilder.Builder

    public struct Relation {
        fileprivate let axis1: LayoutAxis<Axis1>.Relation
        fileprivate let axis2: LayoutAxis<Axis2>.Relation
    }

    public final class Builder {
        private let axis1: _Builder
        private let axis2: _Builder

        fileprivate init(axis1: _Builder, axis2: _Builder) {
            self.axis1 = axis1
            self.axis2 = axis2
        }
    }

    public struct ConstrantGroup {
        fileprivate let axis1: NSLayoutConstraint
        fileprivate let axis2: NSLayoutConstraint
    }
}

extension LayoutAxes.Relation {

    private func axes(_ view: ViewProxy) -> LayoutAxes.Builder {
        let axes = Trait.axes(from: view)
        return .init(axis1: axis1.anchor(axes.axis1), axis2: axis2.anchor(axes.axis2))
    }
}

extension LayoutAxes.Builder {

    private func constant(axis1: CGFloat, axis2: CGFloat) -> LayoutAxes.Builder {
        self.axis1.constant(axis1)
        self.axis2.constant(axis2)
        return self
    }

    public func asConstraints() -> LayoutAxes.ConstrantGroup {
        .init(axis1: axis1.asConstraint(), axis2: axis2.asConstraint())
    }
}

// MARK: - Axes.Center

extension LayoutAxes.Relation where Trait == Axes.Center {

    @discardableResult
    public func center(_ view: ViewProxy) -> LayoutAxes.Builder {
        axes(view)
    }
}

extension LayoutAxes.Builder where Trait == Axes.Center {

    @discardableResult
    public func constant(x: CGFloat, y: CGFloat) -> LayoutAxes.Builder {
        constant(axis1: x, axis2: y)
    }
}

extension LayoutAxes.ConstrantGroup where Trait == Axes.Center {
    public var x: NSLayoutConstraint { axis1 }
    public var y: NSLayoutConstraint { axis2 }
}

// MARK: - Axes.Horizontal

extension LayoutAxes.Relation where Trait == Axes.Horizontal {

    @discardableResult
    public func horizontal(_ view: ViewProxy) -> LayoutAxes.Builder {
        axes(view)
    }
}

extension LayoutAxes.Builder where Trait == Axes.Horizontal {

    @discardableResult
    public func constant(leading: CGFloat, trailing: CGFloat) -> LayoutAxes.Builder {
        constant(axis1: leading, axis2: trailing)
    }
}

extension LayoutAxes.ConstrantGroup where Trait == Axes.Horizontal {
    public var leading: NSLayoutConstraint { axis1 }
    public var trailing: NSLayoutConstraint { axis2 }
}

// MARK: - Axes.Vertical

extension LayoutAxes.Relation where Trait == Axes.Vertical {

    @discardableResult
    public func vertical(_ view: ViewProxy) -> LayoutAxes.Builder {
        axes(view)
    }
}

extension LayoutAxes.Builder where Trait == Axes.Vertical {

    @discardableResult
    public func constant(top: CGFloat, bottom: CGFloat) -> LayoutAxes.Builder {
        constant(axis1: top, axis2: bottom)
    }
}

extension LayoutAxes.ConstrantGroup where Trait == Axes.Vertical {
    public var top: NSLayoutConstraint { axis1 }
    public var bottom: NSLayoutConstraint { axis2 }
}
