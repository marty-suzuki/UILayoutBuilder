//
//  Context.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/09.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

final class Context {

    private var builders: [Builder] = []

    func builder(constraint: NSLayoutConstraint) -> Builder {
        let builder = Builder(constraint: constraint)
        builders.append(builder)
        return builder
    }

    func buildConstraints() -> [NSLayoutConstraint] {
        builders.map { $0.asConstraint() }
    }
}
