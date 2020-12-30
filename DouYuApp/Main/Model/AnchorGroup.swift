//
//  AnchorGroup.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/24.
//

import UIKit

//@objcMembers
class AnchorGroup: NSObject  {
    //游戏图标
    @objc var icon_url : String = ""
    @objc var small_icon_url : String = ""
    @objc var  tag_id : String = ""
    @objc var push_vertical_screen : String = ""
    @objc var push_nearby : String = ""
    
    
    //该组中对应的房间信息
    @objc var room_list : [[String : NSObject]]?{
        didSet {
            guard let room_list = room_list else {return}
            for dict in room_list{
//                print(dict)
                anchors.append(AnchorsModel(dict: dict))
//                print(anchors)
            }
        }
    }
    //组显示的标题
    @objc var tag_name : String = ""
    //组显示图标
    @objc var icon_name :String = "home_header_normal"

    @objc lazy var anchors : [AnchorsModel] = [AnchorsModel]()
    
    init(dict :  [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override init() {
        
    }
    override  func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("this vlaue UndefinedKey")
    }


}
