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

        let view3 = UIView()
        view3.backgroundColor = .green

        view.ulb.add { view in

            view.addSubview(view2) { view2 in

                view2.edges.equalTo.view(view, all: 10)

                view2.addSubview(view3) { view3 in

                    view3.top.equalTo.anchor(view2.top)
                    view3.leading.equalTo.anchor(view2.leading)
                    view3.size.equalTo.view(view2, multiplier: 0.5)
                }
            }
        }
    }
}
