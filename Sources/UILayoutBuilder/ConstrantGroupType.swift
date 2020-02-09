//
//  ConstrantGroupType.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/10.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public protocol ConstrantGroupType {
    func activate()
    func deactivate()
}
