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

    public var edges: LayoutEdges { .init(top: top, leading: leading, bottom: bottom, trailing: trailing) }
    public var size: LayoutSize { .init(width: width, height: height) }
    public var horizontal: LayoutHorizontal { .init(axis1: leading, axis2: trailing) }
    public var vertical: LayoutVertical { .init(axis1: top, axis2: bottom) }
    public var center: LayoutCenter { .init(axis1: centerX, axis2: centerY) }

    private let view: UIView

    init(_ view: UIView) {
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
