//
//  RecommendViewController.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/18.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin)/2
private let kNormalItemH = kItemW * 3  / 4
private let kPreetyItemH = kItemW * 4  / 3
private let kHeaderViewH : CGFloat = 50

private let kCycleViewH  = kScreenW * 3  / 8

private let kGameViewH  : CGFloat = 90

private let kNormelCellID = "kNormelCell"
private let kHeaderViewID = "kHeaderView"
private let kPrettyCellID = "kPrettyCell"

class RecommendViewController: UIViewController{

    //MARK:- 懒加载属性
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    private lazy var collectionView : UICollectionView = {[unowned self] in
        //1创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        //设置内间距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin )
        layout.minimumLineSpacing = 0
        //行间距
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //2创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        print(self.view.bounds)
        collectionView.backgroundColor =  UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormelCellID)
        //注册头

//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.register(UINib(nibName: "CollCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormelCellID)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        return collectionView
    }()
    
    //轮播
    private lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    //滚动分类
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setupUI()
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        loadData()
    }
}

//MARK:- 设置UI内容
extension RecommendViewController{
    private func setupUI(){
        //1.将UICollecttionView添加到控制器View中
        view.addSubview(collectionView)
        //2.将cycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        
        // 3.将gameView加入collectionView中
        collectionView.addSubview(gameView)
        
        //3.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK:- 请求数据
extension RecommendViewController{
    private func loadData(){
        //1.请求推荐数据
        recommendVM.requestData{
            //1.展示推荐数据
            self.collectionView.reloadData()
            
            //2.将数据传递给GameView
            self.gameView.groups = self.recommendVM.anchorGroups
        }
        //2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

//MARK:- 遵守UICollection的DataSource
extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //0.取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        //1.定义cell
        var cell : CollectionBaseCell
        
        //2.获取cell
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionViewPrettyCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormelCellID, for: indexPath) as! CollectionViewNormalCell
        }
        cell.anchor = anchor
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出头view
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollCollectionHeaderView
        
        //2.取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: kItemW, height: kPreetyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}

//MARK:- 遵守UICollection的Delegate
extension RecommendViewController : UICollectionViewDelegate{

}
