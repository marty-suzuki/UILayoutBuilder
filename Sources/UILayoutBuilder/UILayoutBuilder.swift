//
//  UILayoutBuilder.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/05.
//

import UIKit

public protocol UILayoutBuilderCompatible {
    associatedtype UILayoutBuilderBase
    var ulb: UILayoutBuilderExtension<UILayoutBuilderBase> { get }
}

extension UILayoutBuilderCompatible {
    public var ulb: UILayoutBuilderExtension<Self> { .init(self) }
}

public struct UILayoutBuilderExtension<Base> {
    let base: Base

    fileprivate init(_ base: Base) {
        self.base = base
    }
}

extension UIView: UILayoutBuilderCompatible {}

extension UILayoutBuilderExtension where Base: UIView {

    public func add(handler: (ViewProxy) -> Void) {
        handler(ViewProxy(base))
    }
}

public typealias ConstraintBuilder = () -> NSLayoutConstraint
public typealias ConstraintsBuilder = () -> [NSLayoutConstraint]
