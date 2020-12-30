//
//  CollectionCycleCell.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/28.
//

import UIKit

class CollectionCycleCell : UICollectionViewCell {
    //MARK:- 控件属性
    @IBOutlet weak var iconIMageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:- 定义模型属性
    var cycleModel : CycleModel? {
        didSet{
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")
            iconIMageView.kf.setImage(with: iconURL)
        }
    }
    

}
