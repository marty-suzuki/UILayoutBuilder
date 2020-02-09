//
//  Context.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/09.
//

import UIKit

final class Context {

    private(set) var constraints: [NSLayoutConstraint] = []

    func addConstraint(_ constrant: NSLayoutConstraint) {
        constraints.append(constrant)
    }
}
