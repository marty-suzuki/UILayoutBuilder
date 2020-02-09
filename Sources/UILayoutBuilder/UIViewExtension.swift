//
//  UIViewExtension.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/09.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

extension ULBView: UILayoutBuilderCompatible {}

extension UILayoutBuilderExtension where Base: ULBView {

    public func layout(handler: (ViewProxy) -> Void) {
        let context = Context()
        handler(ViewProxy(view: base, context: context))
        NSLayoutConstraint.activate(context.constraints)
    }

    public func asProxy() -> ViewProxy {
        .init(view: base, context: .init())
    }
}

extension ULBView {
    @objc func _add(subview: ULBView) {
        addSubview(subview)
    }
}

#if os(iOS) || os(tvOS)
import UIKit

extension UIStackView {
    @objc override func _add(subview: UIView) {
        addArrangedSubview(subview)
    }
}
#endif
