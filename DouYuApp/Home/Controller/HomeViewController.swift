//
//  HomePageViewController.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/11.
//

import UIKit
private let kTitleViewH : CGFloat  = 40
class HomeViewController: UIViewController{
//    MARK:- 懒加载属性
    private lazy var pageTitleView: PageTitleView = { [weak self ] in
        print(kStatusBarH)
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        //设置代理
        titleView.delegate = self as? PageTitleViewDelegate
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = { [weak self] in
        //1.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        //2.确定所有子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()

//    MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        self.setupUI()
    }
    
}

//MARK:-设置UI界面
extension HomeViewController{
    private func setupUI(){
        // 0.不需要调整UIScrollView的内边距
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
            } else {
                automaticallyAdjustsScrollViewInsets = false
          }
        // 1.设置导航栏
        setupNavgationBar()
        // 2.设置titleView
        view.addSubview(pageTitleView)
        //3.添加contentView
        view.addSubview(pageContentView)
//        pageContentView.backgroundColor = UIColor.purple
    }
    private func setupNavgationBar(){
        //2.设置左侧item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: 40, height: 40)
        //3.设置右侧历史item
//        类函数调用
//        let  historyItem = UIBarButtonItem.createItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let  historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        //4.设置右侧搜索item
        let  searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)

        //5.设置右侧二维码item
        let  qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)

        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }


}

//MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController :PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)  {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK: - 遵守PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
