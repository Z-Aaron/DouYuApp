//
//  File.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/24.
//

import UIKit
import YYModel
class RoomModel: NSObject ,YYModel {
    //房间id
    @objc var room_id : String = ""
    @objc var show_time : Int  = 0
    //房间图片的url
    @objc var  vertical_src : String = ""
    @objc var cate_id : String = ""
    @objc var hot :Int  = 0
    @objc var avatar_small : String = ""
    @objc var specific_status : Int  = 0
    //房间图片
    @objc var  room_src : String = ""
    //房间名称
    @objc var room_name : String = ""
    //游戏名称
    @objc var game_name : String = ""
    //0电脑直播，1手机直播
    @objc var isVertical : Int = 0
    @objc var owner_uid : Int  = 0
    @objc var  ranktype : String = ""
    //主播昵称
    @objc var nickname : String = ""
    //在线人数
    @objc var online : Int = 0
    @objc var show_status : Int  = 0
    @objc var specific_catalog : String = ""
    @objc var  avatar_mid : String = ""
    @objc var jumpUrl : String = ""
    @objc var rmf1 : String = ""
    @objc var rmf2 : String = ""
    @objc var rmf3 : String = ""
    @objc var  rmf4 : String = ""
    @objc var rmf5 : String = ""

    
    init(dict : [String:NSObject]) {
        super.init()
        print(dict)
        setValuesForKeys(dict)
    }
//    init(json:Any) {
//        let array = NSArray.yy_modelArray(with: RoomModel.self, json: jsonData) as! [RoomModel]
//    }
    override  func setValue(_ value: Any?, forUndefinedKey key: String) {
//        print("this vlaue UndefinedKey")
    }
    static func modelContainerPropertyGenericClass() -> [String : Any]? {
        print(["data":AnchorGroup.classForCoder()])
        return ["data":AnchorGroup.classForCoder()]
    }
}
