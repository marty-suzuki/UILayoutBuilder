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

            view.addSubview(view2) { view2 in

                view2.edges.equalTo.view(view, all: 30)

                view2.addSubview(stackView) { stackView in

                    stackView.addSubview(view3, view4) { view3, view4 in
                        view3.width.equalTo.constant(100)
                        view3.width.equalTo.anchor(view3.height)
                    }

                    stackView.center.equalTo.view(view2)
                }
            }
        }

        view4.ulb.layout { view4 in
            view3.ulb.layout { view3 in
                view4.size.equalTo.view(view3)
            }
        }
    }
}
