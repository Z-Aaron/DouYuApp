//
//  BaseGameModel.swift
//  DouYuApp
//
//  Created by mamini on 2021/1/12.
//

import UIKit

class BaseGameModel: NSObject {
    //MARK: - 定义属性
    //组显示的标题
    @objc var tag_name : String = ""
    //游戏图标
    @objc var icon_url : String = ""
    
    //MARK: - 自定义构造函数
    init(dict :[String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override init() {
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

