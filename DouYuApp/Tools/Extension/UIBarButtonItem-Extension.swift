//
//  UIBarButtonItem-Extension.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/12.
//

import UIKit

extension UIBarButtonItem{
////扩展类方法，直接类名调用
//    //  CGPoint.zero 是一个高度为零,宽度为零,原点位置也为零,需要创建边框但还不确定边框大小和位置时,可以使用此常量
//    class func createItem(imageName :String, highImageName : String,size : CGSize) ->UIBarButtonItem{
//        let btn = UIButton()
//
//        btn.setImage(UIImage(named: imageName), for: .normal)
//        btn.setImage(UIImage(named: highImageName), for: .highlighted)
//
//        btn.frame = CGRect(origin: CGPoint.zero, size: size)
//
//        return UIBarButtonItem(customView: btn)
//
//    }
    
//   更多的为构造函数，便利构造函数1：conveniece开头,2:在构造函数中必须明确调用一个设计的构造函数
    convenience  init(imageName :String , highImageName : String = "",size : CGSize = CGSize.zero) {
        // 设置button
        let btn = UIButton()
        
        // 设置button图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        
        if highImageName != ""{
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        // 设置button尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
      
        // 创建UIbarbuttonitem
        self.init(customView:btn)
        
    }
}
