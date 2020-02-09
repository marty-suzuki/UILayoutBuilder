//
//  Builder.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/09.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public struct Builder {

    private let updater: ConstraintUpdater

    init(constraint: NSLayoutConstraint) {
        self.updater = ConstraintUpdater(constraint)
    }

    @discardableResult
    public func multiplier(_ multiplier: CGFloat) -> Builder {
        updater.update(multiplier: multiplier)
        return self
    }

    @discardableResult
    public func constant(_ constant: CGFloat) -> Builder {
        updater.update(constant: constant)
        return self
    }

    @discardableResult
    public func priority(_ priority: LayoutPriority) -> Builder {
        updater.update(priority: priority)
        return self
    }

    public func asConstraint() -> NSLayoutConstraint {
        return updater.constraint
    }
}
