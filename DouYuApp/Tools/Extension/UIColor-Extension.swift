//
//  UIColor-Extension.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/15.
//

import UIKit

extension UIColor{
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat){
        self.init(red : r / 255, green: g / 255, blue: b / 255 , alpha:1.0)
    }
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
