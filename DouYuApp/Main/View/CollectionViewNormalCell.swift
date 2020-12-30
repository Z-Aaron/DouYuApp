//
//  CollectionViewNormalCell.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/21.
//

import UIKit

class CollectionViewNormalCell: CollectionBaseCell {

    //MARK:- 控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    //MARK:- 定义模型属性
    override var anchor :AnchorsModel?{
        didSet{
            super.anchor = anchor
            //3.房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }

}
