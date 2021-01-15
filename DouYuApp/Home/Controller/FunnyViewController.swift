//
//  FunnyViewController.swift
//  DouYuApp
//
//  Created by mamini on 2021/1/14.
//

import UIKit
private let kTopMargin :CGFloat = 8

class FunnyViewController: BaseAnchorViewController {
    //MARK: - 懒加载VM
    fileprivate lazy var funVM : FunnyViewModel = FunnyViewModel()
    
    
}

extension FunnyViewController{
    override func setupUI() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}

extension FunnyViewController{
    override func loadData() {
        //1.给父类中的VM进行赋值
        baseVM = funVM
        
        //2.请求数据
        funVM.loadFunntData {
            self.collectionView.reloadData()
            
            //3.数据请求完成
            self.loadDataFinshed()
        }
    }
}
