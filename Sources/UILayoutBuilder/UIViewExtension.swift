//
//  UIViewExtension.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/09.
//

import UIKit

extension UIView: UILayoutBuilderCompatible {}

extension UILayoutBuilderExtension where Base: UIView {

    public func layout(handler: (ViewProxy) -> Void) {
        let context = Context()
        handler(ViewProxy(view: base, context: context))
        NSLayoutConstraint.activate(context.constraints)
    }

    public func asProxy() -> ViewProxy {
        .init(view: base, context: .init())
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
