//
//  ViewProxy.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/05.
//

import UIKit

public struct ViewProxy {

    public var leading: LayoutXAxis { .init(view, for: \.leadingAnchor) }
    public var trailing: LayoutXAxis  { .init(view, for: \.trailingAnchor) }
    public var left: LayoutXAxis { .init(view, for: \.leftAnchor) }
    public var right: LayoutXAxis { .init(view, for: \.rightAnchor) }
    public var top: LayoutYAxis { .init(view, for: \.topAnchor) }
    public var bottom: LayoutYAxis { .init(view, for: \.bottomAnchor) }
    public var width: LayoutDimension { .init(view, for: \.widthAnchor) }
    public var height: LayoutDimension { .init(view, for: \.heightAnchor) }
    public var centerX: LayoutXAxis { .init(view, for: \.centerXAnchor) }
    public var centerY: LayoutYAxis { .init(view, for: \.centerYAnchor) }
    public var firstBaseline: LayoutYAxis { .init(view, for: \.firstBaselineAnchor) }
    public var lastBaseline: LayoutYAxis { .init(view, for: \.lastBaselineAnchor) }

    private let view: UIView

    public init(_ view: UIView) {
        self.view = view
    }
}

extension ViewProxy {

    public func addSubview(_ subview: UIView, handler: ((ViewProxy) -> Void)? = nil) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subview)
        handler?(ViewProxy(subview))
    }
}

@_functionBuilder
public enum LayoutBuilder {
    public static func buildBloc<L0: LayoutHolder>(_ l0: L0) -> ConstraintGroup {
        ConstraintGroup([l0])
    }

    public static func buildBlock<
        L0: LayoutHolder,
        L1: LayoutHolder
    >(_ l0: L0, _ l1: L1) -> ConstraintGroup {
        ConstraintGroup([l0, l1])
    }

    public static func buildBlock<
        L0: LayoutHolder,
        L1: LayoutHolder,
        L2: LayoutHolder
        >(_ l0: L0, _ l1: L1, _ l2: L2) -> ConstraintGroup {
        ConstraintGroup([l0, l1, l2])
    }

    public static func buildBlock<
        L0: LayoutHolder,
        L1: LayoutHolder,
        L2: LayoutHolder,
        L3: LayoutHolder
        >(_ l0: L0, _ l1: L1, _ l2: L2, _ l3: L3) -> ConstraintGroup {
        ConstraintGroup([l0, l1, l2, l3])
    }

    public static func buildBlock<
        L0: LayoutHolder,
        L1: LayoutHolder,
        L2: LayoutHolder,
        L3: LayoutHolder,
        L4: LayoutHolder
        >(_ l0: L0, _ l1: L1, _ l2: L2, _ l3: L3, _ l4: L4) -> ConstraintGroup {
        ConstraintGroup([l0, l1, l2, l3, l4])
    }
}

public struct LayoutComponent {
    let constraints: [NSLayoutConstraint]
}

public protocol LayoutHolder {
    var layoutComponent: LayoutComponent { get }
}

public struct ConstraintGroup: LayoutHolder {
    public var layoutComponent: LayoutComponent

    init(_ layouts: [LayoutHolder]) {
        self.layoutComponent = LayoutComponent(
            constraints: layouts.flatMap { $0.layoutComponent.constraints }
        )
    }
}

extension NSLayoutConstraint: LayoutHolder {
    public var layoutComponent: LayoutComponent { .init(constraints: [self]) }
}

extension ViewProxy: LayoutHolder {

    public var layoutComponent: LayoutComponent { .init(constraints: []) }

    @discardableResult
    public func addSubview2(_ subview: UIView, @LayoutBuilder builder: (ViewProxy) -> LayoutHolder) -> ViewProxy {
        subview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subview)
        let holder = builder(ViewProxy(subview))
        NSLayoutConstraint.activate(holder.layoutComponent.constraints)
        return self
    }

//    @discardableResult
//    public func addSubview2(_ v1: UIView, _ v2: UIView, @LayoutBuilder builder: (ViewProxy, ViewProxy) -> ConstraintBuilderHolder) -> ConstraintBuilderHolder {
//        [v1, v2].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview($0)
//        }
//        let group = builder(ViewProxy(v1), ViewProxy(v2))
//        NSLayoutConstraint.activate(group.builders.map { $0.build() })
//        return self
//    }
}

extension UIView {

    public func layout(@LayoutBuilder handler: (ViewProxy) -> LayoutHolder) {
        let proxy = ViewProxy(self)
        let constraints = handler(proxy).layoutComponent.constraints
        NSLayoutConstraint.activate(constraints)
    }
}
