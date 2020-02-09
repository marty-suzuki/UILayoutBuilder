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

    override func viewDidLoad() {
        super.viewDidLoad()

        let view2 = UIView()
        view2.backgroundColor = .red

        let stackView = UIStackView()
        stackView.axis = .vertical

        let view3 = UIView()
        view3.backgroundColor = .green

        let view4 = UIView()
        view4.backgroundColor = .yellow

        view.ulb.layout { view in

            view.add.subview(view2) { view2 in

                view2.edges.equalTo.edges(view).constant(30)

                view2.add.subview(stackView) { stackView in

                    stackView.add.subview(view3, view4) { view3, view4 in
                        view3.width.equalTo.constant(100)
                        view3.width.equalTo.anchor(view3.height)
                    }

                    stackView.center.equalTo.center(view2)
                }
            }
        }
    }
}
