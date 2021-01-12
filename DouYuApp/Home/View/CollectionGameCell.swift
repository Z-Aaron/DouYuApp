//
//  CollectionGameCell.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/29.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:- 定义模型属性
    var bashGame : BaseGameModel?{
        didSet{
            titleLabel.text = bashGame?.tag_name
            let iconURL = URL(string: bashGame?.icon_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn"))

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
