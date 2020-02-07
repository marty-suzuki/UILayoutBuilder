//
//  LayoutAxes.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/07.
//

import UIKit

public typealias LayoutHorizontal = LayoutAxes<Axes.Horizontal>
public typealias LayoutVertical = LayoutAxes<Axes.Vertical>
public typealias LayoutCenter = LayoutAxes<Axes.Center>

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
    public typealias Axis1 = Trait.Axis1
    public typealias Axis2 = Trait.Axis2

    public var equalTo: Relation {
        .init(axis1: axis1, axis2: axis2)
    }

    private let axis1: LayoutAxis<Axis1>
    private let axis2: LayoutAxis<Axis2>

    init(axis1: LayoutAxis<Axis1>, axis2: LayoutAxis<Axis2>) {
        self.axis1 = axis1
        self.axis2 = axis2
    }

    public struct Relation {

        fileprivate let axis1: LayoutAxis<Axis1>
        fileprivate let axis2: LayoutAxis<Axis2>

        public func view(_ view: ViewProxy) -> ConstraintsBuilder {
            { [axis1, axis2] in
                let axes = Trait.axes(from: view)
                return [
                    axis1.equalTo.anchor(axes.axis1)(),
                    axis2.equalTo.anchor(axes.axis2)()
                ]
            }
        }
    }
}
