//
//  RecommendViewController.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/18.
//

import UIKit



private let kCycleViewH  = kScreenW * 3  / 8

private let kGameViewH  : CGFloat = 90



class RecommendViewController: BaseAnchorViewController{

    //MARK:- 懒加载属性
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    

    //轮播
    private lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    //滚动分类
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    
}

//MARK:- 设置UI内容
extension RecommendViewController{
    override func setupUI(){
        //1.先调用super
        super.setupUI()
        view.addSubview(collectionView)
        //2.将cycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        
        // 3.将gameView加入collectionView中
        collectionView.addSubview(gameView)
        
        //3.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK:- 请求数据
extension RecommendViewController{
    override func loadData(){
        //0.给父类发VM赋值
        baseVM = recommendVM
        //1.请求推荐数据
        recommendVM.requestData{
            //1.展示推荐数据
            self.collectionView.reloadData()
            
            //2.将数据传递给GameView
            var groups = self.recommendVM.anchorGroups
            
            //2.1移除前两个数据
            groups.removeFirst()
            groups.removeFirst()

            //2.2添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
        }
        //2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

//MARK:- 遵守UICollection的UICollectionViewDelegateFlowLayout
extension  RecommendViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if indexPath.section == 1{
                return CGSize(width: kNormalItemW, height: kPreetyItemH)
            }
            return CGSize(width: kNormalItemW, height: kNormalItemH)
        }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
            if indexPath.section == 1{
               let  prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionViewPrettyCell
                prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
                return prettyCell
            }else{
                return super.collectionView(collectionView,cellForItemAt: indexPath)
            }
    
        }
        
}

