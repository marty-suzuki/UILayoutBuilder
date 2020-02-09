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

    public func layout(handler: (ViewProxy) -> Void) {
        let context = Context()
        handler(ViewProxy(view: base, context: context))
        NSLayoutConstraint.activate(context.constraints)
    }
}

extension UIView {
    @objc func _add(subview: UIView) {
        addSubview(subview)
    }
}

extension UIStackView {
    @objc override func _add(subview: UIView) {
        addArrangedSubview(subview)
    }
}

final class Context {

    private(set) var constraints: [NSLayoutConstraint] = []

    func addConstraint(_ constrant: NSLayoutConstraint) -> NSLayoutConstraint {
        constraints.append(constrant)
        return constrant
    }
}
