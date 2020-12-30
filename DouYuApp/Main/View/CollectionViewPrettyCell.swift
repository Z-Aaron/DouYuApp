//
//  CollectionViewPrettyCell.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/21.
//

import UIKit
import Kingfisher

class CollectionViewPrettyCell: CollectionBaseCell {
   
    //MARK:- 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    //MARK:- 定义模型属性
    override var anchor :AnchorsModel?{
        didSet{
            //1.将属性传递给父类
            super.anchor = anchor
            //2.所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
    }

}
}
