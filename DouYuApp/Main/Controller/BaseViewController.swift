//
//  BaseViewController.swift
//  DouYuApp
//
//  Created by mamini on 2021/1/15.
//

import UIKit

class BaseViewController: UIViewController {

    //MARK: 定义属性
    var contentView : UIView?
    
    //MARK: 懒加载属性
    fileprivate lazy var animImageView : UIImageView = { [unowned self]in
        let imageView = UIImageView(image:UIImage(named:  "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        //执行动画时间
        imageView.animationDuration = 0.5
        //执行次数
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

}

extension BaseViewController{
    @objc func setupUI() {
        //1.隐藏内容的View
        contentView?.isHidden = true
        
        //1.添加执行动画的UIimageView
        view.addSubview(animImageView)
        
        animImageView.startAnimating()
        
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinshed() {
        //1.停止动画
        animImageView.stopAnimating()
        
        //2.隐藏animImageView
        animImageView.isHidden = true
        
        //3.显示内容的View
        contentView?.isHidden = false
    }
}
