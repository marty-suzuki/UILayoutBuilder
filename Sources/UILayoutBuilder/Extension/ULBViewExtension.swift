//
//  ULBViewExtension.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/09.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

extension ULBView {
    @objc func _add(subview: ULBView) {
        addSubview(subview)
    }
}

extension ULBView: UILayoutBuilderCompatible {}

extension UILayoutBuilderExtension where Base: ULBView {

    public var add: ULBViewAddSubview {
        .init(base: base)
    }

    public func asProxy() -> ViewProxy {
        .init(view: base, context: .init())
    }
}

public struct ULBViewAddSubview {
    fileprivate let base: ULBView
}

extension ULBViewAddSubview {

    public func subview(_ subview: ULBView, handler: (ViewProxy, ViewProxy) -> Void = { _, _ in }) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        base._add(subview: subview)

        let context = Context()
        handler(
            ViewProxy(view: base, context: context),
            ViewProxy(view: subview, context: context)
        )
        NSLayoutConstraint.activate(context.constraints)
    }

    public func subview(
        _ subview1: ULBView,
        _ subview2: ULBView,
        handler: (
        ViewProxy,
        ViewProxy,
        ViewProxy
        ) -> Void = { _, _, _ in }
    ) {
        [subview1, subview2].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            base._add(subview: $0)
        }

        let context = Context()
        handler(
            ViewProxy(view: base, context: context),
            ViewProxy(view: subview1, context: context),
            ViewProxy(view: subview2, context: context)
        )
        NSLayoutConstraint.activate(context.constraints)
    }

    public func subview(
        _ subview1: ULBView,
        _ subview2: ULBView,
        _ subview3: ULBView,
        handler: (
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy
        ) -> Void = { _, _, _, _ in }
    ) {
        [subview1, subview2, subview3].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            base._add(subview: $0)
        }

        let context = Context()
        handler(
            ViewProxy(view: base, context: context),
            ViewProxy(view: subview1, context: context),
            ViewProxy(view: subview2, context: context),
            ViewProxy(view: subview3, context: context)
        )
        NSLayoutConstraint.activate(context.constraints)
    }

    public func subview(
        _ subview1: ULBView,
        _ subview2: ULBView,
        _ subview3: ULBView,
        _ subview4: ULBView,
        handler: (
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy
        ) -> Void  = { _, _, _, _, _ in }
    ) {
        [subview1, subview2, subview3, subview4].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            base._add(subview: $0)
        }

        let context = Context()
        handler(
            ViewProxy(view: base, context: context),
            ViewProxy(view: subview1, context: context),
            ViewProxy(view: subview2, context: context),
            ViewProxy(view: subview3, context: context),
            ViewProxy(view: subview4, context: context)
        )
        NSLayoutConstraint.activate(context.constraints)
    }

    public func subview(
        _ subview1: ULBView,
        _ subview2: ULBView,
        _ subview3: ULBView,
        _ subview4: ULBView,
        _ subview5: ULBView,
        handler: (
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy
        ) -> Void = { _, _, _, _, _, _ in }
    ) {
        [subview1, subview2, subview3, subview4, subview5].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            base._add(subview: $0)
        }

        let context = Context()
        handler(
            ViewProxy(view: base, context: context),
            ViewProxy(view: subview1, context: context),
            ViewProxy(view: subview2, context: context),
            ViewProxy(view: subview3, context: context),
            ViewProxy(view: subview4, context: context),
            ViewProxy(view: subview5, context: context)
        )
        NSLayoutConstraint.activate(context.constraints)
    }

    public func subview(
        _ subview1: ULBView,
        _ subview2: ULBView,
        _ subview3: ULBView,
        _ subview4: ULBView,
        _ subview5: ULBView,
        _ subview6: ULBView,
        handler: (
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy
        ) -> Void = { _, _, _, _, _, _, _ in }
    ) {
        [subview1, subview2, subview3, subview4, subview5, subview6].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            base._add(subview: $0)
        }

        let context = Context()
        handler(
            ViewProxy(view: base, context: context),
            ViewProxy(view: subview1, context: context),
            ViewProxy(view: subview2, context: context),
            ViewProxy(view: subview3, context: context),
            ViewProxy(view: subview4, context: context),
            ViewProxy(view: subview5, context: context),
            ViewProxy(view: subview6, context: context)
        )
        NSLayoutConstraint.activate(context.constraints)
    }

    public func subview(
        _ subview1: ULBView,
        _ subview2: ULBView,
        _ subview3: ULBView,
        _ subview4: ULBView,
        _ subview5: ULBView,
        _ subview6: ULBView,
        _ subview7: ULBView,
        handler: (
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy
        ) -> Void = { _, _, _, _, _, _, _, _ in }
    ) {
        [subview1, subview2, subview3, subview4, subview5, subview6, subview7].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            base._add(subview: $0)
        }

        let context = Context()
        handler(
            ViewProxy(view: base, context: context),
            ViewProxy(view: subview1, context: context),
            ViewProxy(view: subview2, context: context),
            ViewProxy(view: subview3, context: context),
            ViewProxy(view: subview4, context: context),
            ViewProxy(view: subview5, context: context),
            ViewProxy(view: subview6, context: context),
            ViewProxy(view: subview7, context: context)
        )
        NSLayoutConstraint.activate(context.constraints)
    }

    public func subview(
        _ subview1: ULBView,
        _ subview2: ULBView,
        _ subview3: ULBView,
        _ subview4: ULBView,
        _ subview5: ULBView,
        _ subview6: ULBView,
        _ subview7: ULBView,
        _ subview8: ULBView,
        handler: (
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy
        ) -> Void = { _, _, _, _, _, _, _, _, _ in }
    ) {
        [subview1, subview2, subview3, subview4, subview5, subview6, subview7, subview8].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            base._add(subview: $0)
        }

        let context = Context()
        handler(
            ViewProxy(view: base, context: context),
            ViewProxy(view: subview1, context: context),
            ViewProxy(view: subview2, context: context),
            ViewProxy(view: subview3, context: context),
            ViewProxy(view: subview4, context: context),
            ViewProxy(view: subview5, context: context),
            ViewProxy(view: subview6, context: context),
            ViewProxy(view: subview7, context: context),
            ViewProxy(view: subview8, context: context)
        )
        NSLayoutConstraint.activate(context.constraints)
    }

    public func subview(
        _ subview1: ULBView,
        _ subview2: ULBView,
        _ subview3: ULBView,
        _ subview4: ULBView,
        _ subview5: ULBView,
        _ subview6: ULBView,
        _ subview7: ULBView,
        _ subview8: ULBView,
        _ subview9: ULBView,
        handler: (
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy
        ) -> Void = { _, _, _, _, _, _, _, _, _, _ in }) {
        [subview1, subview2, subview3, subview4, subview5, subview6, subview7, subview8, subview9].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            base._add(subview: $0)
        }

        let context = Context()
        handler(
            ViewProxy(view: base, context: context),
            ViewProxy(view: subview1, context: context),
            ViewProxy(view: subview2, context: context),
            ViewProxy(view: subview3, context: context),
            ViewProxy(view: subview4, context: context),
            ViewProxy(view: subview5, context: context),
            ViewProxy(view: subview6, context: context),
            ViewProxy(view: subview7, context: context),
            ViewProxy(view: subview8, context: context),
            ViewProxy(view: subview9, context: context)
        )
        NSLayoutConstraint.activate(context.constraints)
    }

    public func subview(
        _ subview1: ULBView,
        _ subview2: ULBView,
        _ subview3: ULBView,
        _ subview4: ULBView,
        _ subview5: ULBView,
        _ subview6: ULBView,
        _ subview7: ULBView,
        _ subview8: ULBView,
        _ subview9: ULBView,
        _ subview10: ULBView,
        handler: (
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy,
        ViewProxy
        ) -> Void = { _, _, _, _, _, _, _, _, _, _, _ in }) {
        [subview1, subview2, subview3, subview4, subview5, subview6, subview7, subview8, subview9, subview10].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            base._add(subview: $0)
        }

        let context = Context()
        handler(
            ViewProxy(view: base, context: context),
            ViewProxy(view: subview1, context: context),
            ViewProxy(view: subview2, context: context),
            ViewProxy(view: subview3, context: context),
            ViewProxy(view: subview4, context: context),
            ViewProxy(view: subview5, context: context),
            ViewProxy(view: subview6, context: context),
            ViewProxy(view: subview7, context: context),
            ViewProxy(view: subview8, context: context),
            ViewProxy(view: subview9, context: context),
            ViewProxy(view: subview10, context: context)
        )
        NSLayoutConstraint.activate(context.constraints)
    }
}
