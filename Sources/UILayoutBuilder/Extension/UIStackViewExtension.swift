//
//  UIStackViewExtension.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/10.
//

#if os(iOS) || os(tvOS)
import UIKit

extension UIStackView {
    @objc override func _add(subview: UIView) {
        addArrangedSubview(subview)
    }
}
#endif
