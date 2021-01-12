//
//  GameViewController.swift
//  DouYuApp
//
//  Created by mamini on 2021/1/11.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH :CGFloat = kItemW * 6 / 5
private let kHeaderViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90
private let kGameCellID = "kGameCellID"
private let kGameCellHeader = "kGameCellHeader"


class GameViewController: UIViewController {
    
    //MARK: 懒加载属性
    fileprivate lazy var gameVM :GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH )
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        //2.创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)

        collectionView.register(UINib(nibName: "CollCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kGameCellHeader)
        return collectionView
    }()
    fileprivate lazy var topHeaderView : CollCollectionHeaderView = {
        let headerView = CollCollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLabel.text = "常用"
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
        
    }()
    
    //MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
        
    }


}

//MARK:- 请求数据
extension GameViewController {
    fileprivate func loadData(){
       
        gameVM.loadAllGameData {
            //1.展示全部游戏
            self.collectionView.reloadData()
            
            //2.展示常用游戏
            self.gameView.groups = Array(self.gameVM.games[0..<10])
        } 
        
    }
}
//MARK:- 设置UI界面
extension GameViewController {
    fileprivate func setupUI(){
        //1.添加collecview
        view.addSubview(collectionView)
        
        //2.添加顶部的topHeaderView
        collectionView.addSubview(topHeaderView)
        
        //3.将常用游戏的view加入collectionView
        collectionView.addSubview(gameView)
        
        //4.设置collectionView设置内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
       
    }
}

//MARK:- 遵守数据源协议
extension GameViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.bashGame = gameVM.games[indexPath.item]

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kGameCellHeader, for: indexPath) as! CollCollectionHeaderView
        
        //2.给headerView设置属性
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
        
    }

}
