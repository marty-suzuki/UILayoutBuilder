//
//  LayoutDimension.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/05.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public struct LayoutDimension {
    typealias RawAnchor = NSLayoutDimension

    private let rawAnchor: RawAnchor
    private let context: Context

    init(_ view: ULBView, for keyPath: KeyPath<ULBView, RawAnchor>, context: Context) {
        self.rawAnchor = view[keyPath: keyPath]
        self.context = context
    }
}

#if os(iOS) || os(tvOS)
extension LayoutDimension {

    init(_ layoutGuide: UILayoutGuide, for keyPath: KeyPath<UILayoutGuide, RawAnchor>, context: Context) {
        self.rawAnchor = layoutGuide[keyPath: keyPath]
        self.context = context
    }
}
#endif

extension LayoutDimension {

    public var equalTo: Relation {
        .init(toAnchor: { [rawAnchor] in rawAnchor.constraint(equalTo: $0) },
              toConstant: { [rawAnchor] in rawAnchor.constraint(equalToConstant: $0) },
              context: context)
    }

    public var greaterThanOrEqualTo: Relation {
        .init(toAnchor: { [rawAnchor] in rawAnchor.constraint(greaterThanOrEqualTo: $0) },
              toConstant: { [rawAnchor] in rawAnchor.constraint(greaterThanOrEqualToConstant: $0) },
              context: context)
    }

    public var lessThanOrEqualTo: Relation {
        .init(toAnchor: { [rawAnchor] in rawAnchor.constraint(lessThanOrEqualTo: $0) },
              toConstant: { [rawAnchor] in rawAnchor.constraint(lessThanOrEqualToConstant: $0) },
              context: context)
    }
}

extension LayoutDimension {
    public typealias Builder = UILayoutBuilder.Builder

    public struct Relation {
        fileprivate let toAnchor: (RawAnchor) -> NSLayoutConstraint
        fileprivate let toConstant: (CGFloat) -> NSLayoutConstraint
        fileprivate let context: Context
    }
}

extension LayoutDimension.Relation {

    @discardableResult
    private func anchor(_ anchor: LayoutDimension) -> LayoutDimension.Builder {
        context.builder(constraint: toAnchor(anchor.rawAnchor))
    }

    @discardableResult
    public func constant(_ constant: CGFloat) -> LayoutDimension.Builder {
        context.builder(constraint: toConstant(constant))
    }

    @discardableResult
    public func height(_ layout: LayoutRepresentable) -> LayoutDimension.Builder {
        anchor(layout.height)
    }

    @discardableResult
    public func width(_ layout: LayoutRepresentable) -> LayoutDimension.Builder {
        anchor(layout.width)
    }
}

