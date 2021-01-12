//
//  CollCollectionHeaderView.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/19.
//

import UIKit

class CollCollectionHeaderView: UICollectionReusableView {
    //MARK:- 控件绑定
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    
    //MARK:- 定义属性模型
    var group :AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal" )
        }
    }
   
}
//MARK: - 从xib中快速创建方法
extension CollCollectionHeaderView{
    class func collectionHeaderView() -> CollCollectionHeaderView{
        return Bundle.main.loadNibNamed("CollCollectionHeaderView", owner: nil, options: nil)?.first as! CollCollectionHeaderView
    }
}
