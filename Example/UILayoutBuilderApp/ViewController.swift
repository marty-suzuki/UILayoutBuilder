//
//  ViewController.swift
//  UILayoutBuilderApp
//
//  Created by marty-suzuki on 2020/02/05.
//  Copyright © 2020 marty-suzuki. All rights reserved.
//

import UIKit
import UILayoutBuilder

class ViewController: UIViewController {

    private let greenView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .green
        return view
    }()

    private let whiteView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()

    private let redView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .red
        return view
    }()

    private var greenViewBottomConstraint: NSLayoutConstraint?
    private var whiteViewWidthConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        let yellowView = UIView()
        yellowView.backgroundColor = .yellow

        view.ulb.add.subview(yellowView, redView) { view, yellowView, redView in

            redView.top.equalTo.top(view.safeAreaLayoutGuide).constant(-10)
            redView.leading.equalTo.leading(view.safeAreaLayoutGuide).constant(10)
            redView.trailing.equalTo.trailing(view.safeAreaLayoutGuide).constant(-10)
            redView.height.equalTo.height(view.safeAreaLayoutGuide).multiplier(0.5).constant(-15)

            yellowView.top.equalTo.bottom(redView).constant(10)
            yellowView.leading.equalTo.leading(view.safeAreaLayoutGuide).constant(10)
            yellowView.trailing.equalTo.trailing(view.safeAreaLayoutGuide).constant(-10)
            yellowView.height.equalTo.height(view.safeAreaLayoutGuide).multiplier(0.5).constant(-15)

            yellowView.add.subview(greenView) { greenView in
                greenView.top.equalTo.top(yellowView)
                greenView.trailing.equalTo.trailing(yellowView)
                greenViewBottomConstraint = greenView.bottom.equalTo.bottom(yellowView).asConstraint()
                greenView.width.equalTo.width(yellowView).multiplier(0.5)
            }

            redView.add.subview(whiteView) { whiteView in
                whiteView.bottom.equalTo.bottom(redView).constant(-10)
                whiteView.leading.equalTo.leading(redView).constant(10)
                whiteView.height.equalTo.constant(100)
            }
        }

        updateWhiteViewConstraint()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reduceAnimation()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateWhiteViewConstraint()
    }

    private func updateWhiteViewConstraint() {
        self.whiteViewWidthConstraint?.isActive = false

        let whiteView = self.whiteView.ulb.asProxy()
        let redView = self.redView.ulb.asProxy()

        let constraint: NSLayoutConstraint
        if traitCollection.verticalSizeClass == .regular && traitCollection.horizontalSizeClass == .compact {
            constraint = whiteView.width.equalTo.width(redView).constant(-10).multiplier(0.5).asConstraint()
        } else {
            constraint = whiteView.width.equalTo.width(redView).constant(-20).asConstraint()
        }
        constraint.isActive = true
        self.whiteViewWidthConstraint = constraint
    }

    private func stretchAnmation() {
        greenViewBottomConstraint?.constant = 0
        UIView.animate(withDuration: 2, animations: {
            self.greenView.superview?.layoutIfNeeded()
        }) { _ in
            self.reduceAnimation()
        }
    }

    private func reduceAnimation() {
        let constant = self.greenView.superview?.frame.size.height ?? 0
        greenViewBottomConstraint?.constant = -constant / 2
        UIView.animate(withDuration: 2, animations: {
            self.greenView.superview?.layoutIfNeeded()
        }) { _ in
            self.stretchAnmation()
        }
    }
}
