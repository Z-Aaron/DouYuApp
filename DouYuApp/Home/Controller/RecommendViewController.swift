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
        
    }
}

//MARK:- 请求数据
extension RecommendViewController{
    private func loadData(){
        recommendVM.requestData()
    }
}

//MARK:- 遵守UICollection的DataSource
extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 8
        }
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell!
        
        //1获取cell
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormelCellID, for: indexPath)
        }

//        cell.backgroundColor = UIColor.red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出头view
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
//        headerView.backgroundColor = UIColor.green
        
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
