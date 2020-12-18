//
//  PageContentView.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/15.
//

import UIKit

protocol PageContentViewDelegate: class {
    func pageContentView(contentView : PageContentView , progress : CGFloat,sourceIndex :Int , targetIndex :Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
     //MARK:- 定义属性
    private var childVcs : [UIViewController]
    private  weak var parentViewController : UIViewController?
    private var startOffsetX :CGFloat = 0
    weak var delegate :PageContentViewDelegate?
    private var isForbirdScrollDelegate : Bool = false
    
//闭包中用self很可能循环引用，一般使用weak
    private lazy var conllectionView : UICollectionView = { [weak self] in
//        1。创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
//       行间距
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
//        水平滚动
        layout.scrollDirection = .horizontal
        
//        2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:  layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    init(frame: CGRect , childVcs: [UIViewController] , parentViewController:UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        //设置UI
        setupUI()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- 设置UI界面
extension PageContentView{
    private func setupUI(){
        //1.将所有子控制器添加到父控制器中
        for childVc in childVcs {
            parentViewController?.addChild(childVc)
        }
        //2.添加UICollectionView
        addSubview(conllectionView)
        conllectionView.frame = bounds
    }
}

//MARK:- 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        

//        2.因为cell的循环使用，会导致添加多次的问题
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        //        3.设置cell内容
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
}
//MARK:- 遵守UICollectionViewDelegate
extension PageContentView:UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView : UIScrollView)  {
        isForbirdScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView :UIScrollView) {
        //判断是否是点击事件
        if isForbirdScrollDelegate { return }
        
        //1.获取需要的数据
        var  progress : CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        //2.判断是左滑还是右滑
        let currentoffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentoffsetX > startOffsetX{
            //左滑
            progress = currentoffsetX / scrollViewW - floor(currentoffsetX / scrollViewW)
            //计算sourceIndex
            sourceIndex = Int(currentoffsetX / scrollViewW)
            //计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count-1
            }
            //4.如果完全滑过去
            if currentoffsetX - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
            //右滑
            progress = 1 - (currentoffsetX / scrollViewW - floor(currentoffsetX / scrollViewW))
            //计算targetIndex
            targetIndex =  Int(currentoffsetX / scrollViewW)
            //计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
            }

        }
        //3.将sourceIndex，targetIndex传递给titleView
        print("progress:\(progress) souceIndex:\(sourceIndex) targetIndex:\(targetIndex)")
    
        delegate?.pageContentView(contentView : self , progress : progress ,sourceIndex :sourceIndex , targetIndex :targetIndex)
        
        
    }
}



//MARK:- 对外暴露的方法
extension PageContentView{
    func setCurrentIndex(currentIndex :Int)  {
        //记录禁止执行代理方法
        isForbirdScrollDelegate = true
        
        //滚动到
        let offsetX = CGFloat( currentIndex) * conllectionView.frame.width
        conllectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}

