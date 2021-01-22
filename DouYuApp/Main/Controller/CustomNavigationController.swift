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
       
        //MARK:- 全屏手势
        //1.获取系统pop手势
        guard let systemGes = interactivePopGestureRecognizer else{return}
        
        //2.获取手势添加到View中
        guard let gesView = systemGes.view else {
            return
        }
        
        //3.获取target/action
        //3.1利用运行时机制查看所有属性名称
//        var count : UInt32 = 0
//        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
//        for i in 0..<count{
//            let ivar = ivars[Int(i)]
//            let name = ivar_getName(ivar)
//            print(String(cString: name!))
//        }
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else{return}
        print(targetObjc)
        
        //3.2取出target
        guard let target = targetObjc.value(forKey: "target") else{return}
        
        //3.3取出action
        let action = Selector(("handleNavigationTransition:"))
        
        //3.4创建自己的手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
        
        
        

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //隐藏要push的控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: true)
    }

}
