//
//  AmuseViewController.swift
//  DouYuApp
//
//  Created by mamini on 2021/1/12.
//

import UIKit

private let kMenuViewH :CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    
    //MARK:- 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView =  {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        
        return menuView
    }()
    
}
//MARK:- 设置UI界面
extension AmuseViewController{
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK:- 请求数据
extension AmuseViewController{
    override func loadData(){
        //1.给父类中的VM赋值
        baseVM = amuseVM
        //1.请求推荐数据
        amuseVM.loadAmiseData {
            self.collectionView.reloadData()
            var tmpGroups = self.amuseVM.anchorGroups
            tmpGroups.removeFirst()
            self.menuView.groups = tmpGroups
            //3.数据请求完成
            self.loadDataFinshed()
        }
    }
}
