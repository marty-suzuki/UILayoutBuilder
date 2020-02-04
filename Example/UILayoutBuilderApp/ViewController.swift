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

                NSLayoutConstraint.activate([
                    view2.leading.equalTo.anchor(view.leading).constant(10).build(),
                    view2.trailing.equalTo.anchor(view.trailing).constant(-10).build(),
                    view2.bottom.equalTo.anchor(view.bottom).constant(-10).build(),
                    view2.top.equalTo.anchor(view.top).constant(10).build()
                ])

                view2.addSubview(view3) { view3 in
                    
                    NSLayoutConstraint.activate([
                        view3.top.equalTo.anchor(view2.top).build(),
                        view3.leading.equalTo.anchor(view2.leading).build(),
                        view3.width.equalTo.anchor(view2.width).multiplier(0.5).build(),
                        view3.height.equalTo.anchor(view2.height).multiplier(0.5).build()
                    ])
                }
            }
        }
    }
}
