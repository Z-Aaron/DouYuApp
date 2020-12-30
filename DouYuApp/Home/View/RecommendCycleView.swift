//
//  RecommendCycleView.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/28.
//

import UIKit
private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    
    //MARK:- 定义属性
    var cycleTimer : Timer?
    var cycleModels : [CycleModel]? {
        didSet{
            //1.刷新collectionView
            collectionView.reloadData()
            
            //2.设置pageController个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //3.默认滚动到中间的某个位置
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0 )*100, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            //4.移除定时器
            removeCycleTimer()
            //5.添加定时器
            addCycleTimer()
            
        }
    }
    
    //MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随父控件拉伸而拉伸
//        autoresizingMask = .None
        
        collectionView.dataSource = self
        collectionView.delegate = self
        //注册cell
                collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)


    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //设置collectionView布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
    }

}
//MARK:- 提供一个快速创建View的类方法
extension RecommendCycleView{
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//MARK:- 遵守UICollectionView数据源协议
extension RecommendCycleView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ??  0 ) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
            
        let index = indexPath.item % cycleModels!.count
        cell.cycleModel = cycleModels![index]
        return cell
    }
    
    
}

//MARK:- 遵守UICollectionView代理协议
extension RecommendCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    //监听拖拽开始，关闭定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    //监听拖拽结束，打开定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        removeCycleTimer()
        addCycleTimer()
    }
    
}


//MARK:- 对定时器的操作方法
extension RecommendCycleView{
    private func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    private func removeCycleTimer(){
        //runloop移除timer
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    @objc private func scrollToNext(){
        //1.获取偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        //2.滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
