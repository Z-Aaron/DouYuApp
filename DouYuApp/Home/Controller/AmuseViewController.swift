//
//  AmuseViewController.swift
//  DouYuApp
//
//  Created by mamini on 2021/1/12.
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

class AmuseViewController: UIViewController {
    
    //MARK:- 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
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
        collectionView.register(UINib(nibName: "CollCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormelCellID)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setupUI()
//        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        loadData()
    }
    
}

//MARK:- 设置UI内容
extension AmuseViewController{
    private func setupUI(){
        //1.将UICollecttionView添加到控制器View中
        view.addSubview(collectionView)
  
//        //3.设置collectionView的内边距
//        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK:- 请求数据
extension AmuseViewController{
    private func loadData(){
        //1.请求推荐数据
        amuseVM.loadAmiseData {
            self.collectionView.reloadData()
        }
    }
}
//MARK:- 遵守UICollection的DataSource
extension AmuseViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return amuseVM.anchorGroups[section].anchors.count
            
        }
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return amuseVM.anchorGroups.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            //1.定义cell
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormelCellID, for: indexPath) as! CollectionViewNormalCell
            
            cell.anchor = amuseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            
            return cell

        }
        
       
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("点击")
        }
        
      
    }
