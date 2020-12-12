//
//  HomePageViewController.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/11.
//

import UIKit

class HomeViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        self.setupUI()
    }
    
}

//MARK:-设置UI界面
extension HomeViewController{
    private func setupUI(){
        // 1.设置导航栏
        setupNavgationBar()
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
