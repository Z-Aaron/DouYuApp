//
//  AnchorsModel.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/25.
//

import UIKit

class AnchorsModel: NSObject  {
    //房间id
    @objc var room_id : Int = 0

    //房间图片的url
    @objc var  vertical_src : String = ""
    //房间图片
    @objc var  room_src : String = ""
    //房间名称
    @objc var room_name : String = ""
    //游戏名称
    @objc var game_name : String = ""
    //0电脑直播，1手机直播
    @objc var isVertical : Int = 0
    //主播昵称
    @objc var nickname : String = ""
    //在线人数
    @objc var online : Int = 0
    //所在城市
    @objc var anchor_city : String = ""

    
    init(dict : [String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("this vlaue UndefinedKey")
    }
//    init(json:Any) {
//        let array = NSArray.yy_modelArray(with: RoomModel.self, json: jsonData) as! [RoomModel]
//    }

 
}
