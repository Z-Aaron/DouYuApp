//
//  Common.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/12.
//

import UIKit

let kNavigationBarH : CGFloat = 44

//适配不同机型的状态栏
let kStatusBarH : CGFloat = {if #available(iOS 13.0, *) {
    let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
    return statusBarManager!.statusBarFrame.size.height
}else{
    return  UIApplication.shared.statusBarFrame.size.height
}}()
let KBottomSafe: CGFloat =  { if (kStatusBarH == 20){
    return 0
}else{
    return 34
}}()

let KTabBarH : CGFloat =  { if (kStatusBarH == 20){
    return 49
}else{
    return 83
}}()


let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
//let kTitleViewH : CGFloat  = 40
//private func setNoUIScrollViewInsets(){
//    // 0.不需要调整UIScrollView的内边距
//    if #available(iOS 11.0, *) {
//        UIScrollView.appearance().contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
//        } else {
//            automaticallyAdjustsScrollViewInsets = false
//      }
//}

