//
//  PageTitleView.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/12.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {
    //    MARK:- 自定义属性
    private var currentIndex : Int = 0
    private var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    
    //    MARK:- 获取label
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    //    MARK:- 懒加载属性
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        //  水平线不显示
        scrollView.showsHorizontalScrollIndicator = false
        //  上面滚动
        scrollView.scrollsToTop = false
        //  不超过内容范围
        scrollView.bounces = false
        
        return scrollView
    }()
    
    //MARK:- 懒加载scrollLine
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
     
    //    MARK:- 自定义构造函数
    //    自定义构造函数必须重写 required init函数
    init(frame: CGRect ,titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
//MARK:- 设置UI界面
extension PageTitleView{
    private func setUI(){
        // 1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        // 2.添加title
        setupTitleLabels()
        // 2.添加底线
        setupBottomMenuAndScrollLine()
    }
    private func setupTitleLabels(){
        //0.确定label的frame值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let  labelH : CGFloat = frame.height - kScrollLineH
        let labelY :CGFloat = 0
        for (index , title) in titles.enumerated(){
            // 1.创建UILabel
            let label = UILabel()
            // 2.设置UILabel
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            // 3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            print(labelX,labelY,labelW,labelH)
            //4.将label加入到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5.给label添加手势
            label.isUserInteractionEnabled = true
            let  tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    private func setupBottomMenuAndScrollLine(){
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: lineH)
        addSubview(bottomLine)
        //2.添加scrollLine
        //2.1获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        //2.2设置scrollLine的属性
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}
 
//MARK: - 监听label的点击
extension PageTitleView {
    //监听需要加@objc
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer){
        //0.获取当前label的下标值
        guard let currentLabel = tapGes.view as? UILabel else{return}
        
        //1.如果重复点击一个tile，直接返回
        if currentLabel.tag == currentIndex { return }
        
        //2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //3.切换文字颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        //4.保存现在label
        currentIndex = currentLabel.tag
        //5.改变滚动条
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        //6.加动画
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //6.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}


//MARK:- 对外暴露的方法
extension PageTitleView{
    func setTitleWithProgress(progress : CGFloat,sourceIndex :Int , targetIndex :Int){
        print("三个值：progress：\(progress)，sourceIndex：\(sourceIndex)，sourceIndex：\(sourceIndex)")
        //1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        //2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        //3颜色渐变
        //3.1颜色变化范围
        let colorDelta  = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        //3.2变化souceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress , g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        //3.2变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0  * progress, g:   kNormalColor.1 + colorDelta.1  * progress, b:  kNormalColor.2 + colorDelta.2  * progress)
        
    }
}
