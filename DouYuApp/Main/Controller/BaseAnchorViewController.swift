//
//  BaseAnchorViewController.swift
//  DouYuApp
//
//  Created by mamini on 2021/1/13.
//

import UIKit
private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kNormelCellID = "kNormelCell"
private let kHeaderViewID = "kHeaderView"

let kPrettyCellID = "kPrettyCell"
let kNormalItemW = (kScreenW - 3 * kItemMargin)/2
let kNormalItemH = kNormalItemW * 3  / 4
let kPreetyItemH = kNormalItemW * 4  / 3

class BaseAnchorViewController: BaseViewController {

    //MARK: 定义属性
    var baseVM : BaseViewModel!
    lazy var collectionView : UICollectionView = {[unowned self] in
        //1创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
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
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return collectionView
    }()
    //MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setupUI()
        loadData()
    }

}

//MARK:- 设置UI内容
extension BaseAnchorViewController{
    override func setupUI(){

        //给父类中内容view引用进行赋值
        contentView = collectionView
        
        //1.将UICollecttionView添加到控制器View中
        view.addSubview(collectionView)
        
        super.setupUI()
        
  
    }
}


//MARK:- 请求数据
extension BaseAnchorViewController{
    @objc func loadData(){
    }
}

//MARK:- 遵守UICollection的DataSource
extension BaseAnchorViewController : UICollectionViewDataSource{

        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            
            return baseVM.anchorGroups[section].anchors.count
            
        }
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return baseVM.anchorGroups.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            //1.定义cell
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormelCellID, for: indexPath) as! CollectionViewNormalCell
            
            cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            
            return cell

        }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollCollectionHeaderView
        
        headerView.group = baseVM.anchorGroups[indexPath.section]
        
        return headerView
    }
       
        
      
    }

//MARK:- 遵守UICollectionViewDelegate
extension BaseAnchorViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //1.取出主播信息
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        //判断是秀场房间还是普通房间
        anchor.isVertical == 0 ? pushNormalRoomVC() : presentShowRoomVC()
    }
    
    private func presentShowRoomVC(){
        let showRoomVC = RoomShowViewController()
        
        //model方式弹出
        present(showRoomVC, animated: true, completion: nil)
    }
    private func pushNormalRoomVC(){
        
        let normalRoomVC = RoomNormalViewController()
        
        //push方式弹出
        navigationController?.pushViewController(normalRoomVC, animated: true)
    }
}
