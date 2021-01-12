//
//  NSDate-Extension.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/22.
//

import Foundation

extension NSDate{
    static func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSinceReferenceDate
        print("\(interval)")
        return "\(interval)"
        
    }
}
