//
//  ViewProxy.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/05.
//

import UIKit

public struct ViewProxy {

    private let view: UIView
    private let context: Context

    init(view: UIView, context: Context) {
        self.view = view
        self.context = context
    }
}

extension ViewProxy {
    public var leading      : LayoutXAxis      { .init(view, for: \.leadingAnchor, context: context) }
    public var trailing     : LayoutXAxis      { .init(view, for: \.trailingAnchor, context: context) }
    public var left         : LayoutXAxis      { .init(view, for: \.leftAnchor, context: context) }
    public var right        : LayoutXAxis      { .init(view, for: \.rightAnchor, context: context) }
    public var top          : LayoutYAxis      { .init(view, for: \.topAnchor, context: context) }
    public var bottom       : LayoutYAxis      { .init(view, for: \.bottomAnchor, context: context) }
    public var width        : LayoutDimension  { .init(view, for: \.widthAnchor, context: context) }
    public var height       : LayoutDimension  { .init(view, for: \.heightAnchor, context: context) }
    public var centerX      : LayoutXAxis      { .init(view, for: \.centerXAnchor, context: context) }
    public var centerY      : LayoutYAxis      { .init(view, for: \.centerYAnchor, context: context) }
    public var firstBaseline: LayoutYAxis      { .init(view, for: \.firstBaselineAnchor, context: context) }
    public var lastBaseline : LayoutYAxis      { .init(view, for: \.lastBaselineAnchor, context: context) }

    public var edges        : LayoutEdges      { .init(top: top, leading: leading, bottom: bottom, trailing: trailing) }
    public var size         : LayoutSize       { .init(width: width, height: height) }
    public var center       : LayoutCenter     { .init(axis1: centerX, axis2: centerY) }
    public var horizontal   : LayoutHorizontal { .init(axis1: leading, axis2: trailing) }
    public var vertical     : LayoutVertical   { .init(axis1: top,     axis2: bottom) }
}

extension ViewProxy {

    public func addSubview(_ subview: UIView, handler: ((ViewProxy) -> Void)? = nil) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subview)
        handler?(ViewProxy(view: subview, context: context))
    }
}
