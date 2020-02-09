//
//  LayoutRepresentable.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/09.
//

public protocol LayoutRepresentable {
    var leading      : LayoutXAxis      { get }
    var trailing     : LayoutXAxis      { get }
    var left         : LayoutXAxis      { get }
    var right        : LayoutXAxis      { get }
    var top          : LayoutYAxis      { get }
    var bottom       : LayoutYAxis      { get }
    var width        : LayoutDimension  { get }
    var height       : LayoutDimension  { get }
    var centerX      : LayoutXAxis      { get }
    var centerY      : LayoutYAxis      { get }

    var edges        : LayoutEdges      { get }
    var size         : LayoutSize       { get }
    var center       : LayoutCenter     { get }
    var horizontal   : LayoutHorizontal { get }
    var vertical     : LayoutVertical   { get }
}
