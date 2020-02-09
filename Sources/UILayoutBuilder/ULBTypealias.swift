//
//  ULBTypealias.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/09.
//

#if os(iOS) || os(tvOS)
import UIKit
public typealias ULBView = UIView
public typealias LayoutPriority = UILayoutPriority
#else
import AppKit
public typealias ULBView = NSView
public typealias LayoutPriority = NSLayoutConstraint.Priority
#endif
