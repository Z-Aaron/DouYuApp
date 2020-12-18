//
//  RecommendViewController.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/18.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin)/2
private let kItemH = kItemW * 3  / 4
private let kNormelCellID = "kNormelCell"
private let kHeaderViewID = "kHeaderView"

class RecommendViewController: UIViewController{

    //MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = {
        //1创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        //行间距
        layout.minimumInteritemSpacing = kItemMargin
        
        //2创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.blue
        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormelCellID)
        //注册头

        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind:UICOllection , withReuseIdentifier: kHeaderViewID)
        
        return collectionView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //设置UI
        setUI()

    }

}

//MARK:- 遵守UICollection的DataSource
extension RecommendViewController : UICollectionViewDataSource{
    func numberOfSectionInCollectioinView(collectionView : UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormelCellID, for: indexPath)
        cell.backgroundColor = UIColor.red
        
        return cell
    }
    
}

////MARK:- 遵守UICollection的Delegate
//extension RecommendViewController : UICollectionViewDelegate{
//
//}

//MARK:- 设置UI内容
extension RecommendViewController{
    private func setUI(){
        //1.将UICollecttionView添加到控制器View中
        view.addSubview(collectionView)
    }
}
