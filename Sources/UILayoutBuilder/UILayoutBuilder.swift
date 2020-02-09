//
//  UILayoutBuilder.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/05.
//

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
