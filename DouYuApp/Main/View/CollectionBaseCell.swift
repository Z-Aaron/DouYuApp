//
//  CollectionBaseCell.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/28.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    //MARK:- 控件属性
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    //MARK:- 定义模型属性
    var anchor :AnchorsModel?{
        didSet{
            //0.校验是否有值
            guard let anchor = anchor else {
                return
            }
            //1.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000{
                onlineStr = "\(Double(anchor.online/10000))万人在线"
            }else{
                onlineStr = "\(anchor.online)人在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            //2.昵称的显示
            nickNameLabel.text = anchor.nickname
            //3.设置封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else {
                return
            }
            iconImageView.kf.setImage(with: iconURL)
        }


}
}
