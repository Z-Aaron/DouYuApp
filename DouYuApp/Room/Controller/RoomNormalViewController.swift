//
//  RoomNormalViewController.swift
//  DouYuApp
//
//  Created by mamini on 2021/1/15.
//

import UIKit

class RoomNormalViewController: UIViewController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: false)
        
//        //添加手势
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(false, animated: true)

    }

}
