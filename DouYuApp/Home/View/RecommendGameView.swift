//
//  RecommendGameView.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/29.
//

import UIKit
private let kgameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 15
class RecommendGameView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- 定义属性数据
    var groups : [BaseGameModel]?{
        didSet{
//            //1.移除前两组数据
//            groups?.removeFirst()
//            groups?.removeFirst()
//            
//            //2.添加更多组
//            let moreGroup = AnchorGroup()
//            moreGroup.tag_name = "更多"
//            groups?.append(moreGroup)
            
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //让控件不随着父控件拉伸而拉伸改动
        
        //注册cell    
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kgameCellID)
        
        //给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)

    }

}
//MARK:- 提供快速创建的类方法
extension RecommendGameView{
    class func recommendGameView() ->RecommendGameView {
        return  Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

//MARK:- 遵守UICollectionView协议
extension RecommendGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kgameCellID, for: indexPath) as! CollectionGameCell
        
        cell.bashGame = groups![indexPath.item]
        
        
        return cell
    }
    
    
    
}
