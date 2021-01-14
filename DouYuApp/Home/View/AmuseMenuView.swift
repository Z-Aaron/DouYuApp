//
//  AmuseMenuView.swift
//  DouYuApp
//
//  Created by mamini on 2021/1/14.
//

import UIKit
private let kMenuCellID = "kMenuCellID"

class AmuseMenuView: UIView {
    
    //MARK:- 定义属性
    var groups : [AnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    //MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK:- 从xib中加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register( UINib(nibName: "AmuseMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    //在layoutSubviews 中的bounds是正确的
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
    
}

extension AmuseMenuView {
    class func amuseMenuView() ->AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner:  nil, options: nil )?.first as! AmuseMenuView
    }
}

extension AmuseMenuView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil { return 0}
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.设置cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath)as! AmuseMenuCollectionViewCell
        //2.给cell设置背景颜色
        setupCellDataWithCell(cell: cell, indexpath: indexPath)
        return cell
    }
    
    private func setupCellDataWithCell(cell: AmuseMenuCollectionViewCell,indexpath:IndexPath){
        //1.第0页：0-7，第一页：8-15， 第二页：16-23
        //选取出起始位置和终点位置
        let startIndex = indexpath.item * 8
        var endIndex = (indexpath.item + 1) * 8 - 1
        
        //判断越界
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        //取出数据
        cell.groups = Array(groups![startIndex...endIndex])
        
    }
    
}

extension AmuseMenuView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
