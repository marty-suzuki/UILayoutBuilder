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

        view.ulb.add { view in

            view.addSubview(view2) { view2 in

                view2.edges.equalTo.view(view, all: 30)

                view2.addSubview(stackView) { stackView in

                    stackView.addSubview(view3) { view3 in
                        view3.size.equalTo.size(width: 100, height: 100)
                    }

                    stackView.addSubview(view4) { view4 in
                        view4.size.equalTo.size(width: 100, height: 100)
                    }

                    stackView.center.equalTo.view(view2)
                }
            }
        }
    }
}
