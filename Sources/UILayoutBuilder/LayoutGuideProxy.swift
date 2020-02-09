//
//  LayoutGuideProxy.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/09.
//

#if os(iOS) || os(tvOS)
import UIKit

public struct LayoutGuideProxy {
    private let layoutGuide: UILayoutGuide
    private let context: Context

    init(layoutGuide: UILayoutGuide, context: Context) {
        self.layoutGuide = layoutGuide
        self.context = context
    }
}

extension LayoutGuideProxy: LayoutRepresentable {
    public var leading      : LayoutXAxis      { .init(layoutGuide, for: \.leadingAnchor, context: context) }
    public var trailing     : LayoutXAxis      { .init(layoutGuide, for: \.trailingAnchor, context: context) }
    public var left         : LayoutXAxis      { .init(layoutGuide, for: \.leftAnchor, context: context) }
    public var right        : LayoutXAxis      { .init(layoutGuide, for: \.rightAnchor, context: context) }
    public var top          : LayoutYAxis      { .init(layoutGuide, for: \.topAnchor, context: context) }
    public var bottom       : LayoutYAxis      { .init(layoutGuide, for: \.bottomAnchor, context: context) }
    public var width        : LayoutDimension  { .init(layoutGuide, for: \.widthAnchor, context: context) }
    public var height       : LayoutDimension  { .init(layoutGuide, for: \.heightAnchor, context: context) }
    public var centerX      : LayoutXAxis      { .init(layoutGuide, for: \.centerXAnchor, context: context) }
    public var centerY      : LayoutYAxis      { .init(layoutGuide, for: \.centerYAnchor, context: context) }

    public var edges        : LayoutEdges      { .init(top: top, leading: leading, bottom: bottom, trailing: trailing) }
    public var size         : LayoutSize       { .init(width: width, height: height) }
    public var center       : LayoutCenter     { .init(axis1: centerX, axis2: centerY) }
    public var horizontal   : LayoutHorizontal { .init(axis1: leading, axis2: trailing) }
    public var vertical     : LayoutVertical   { .init(axis1: top,     axis2: bottom) }
}
#endif
