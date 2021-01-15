//
//  CustomNavigationController.swift
//  DouYuApp
//
//  Created by mamini on 2021/1/15.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
      

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //隐藏要push的控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: true)
    }

}
