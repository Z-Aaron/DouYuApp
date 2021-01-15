//
//  RecommendViewModel.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/22.
//

import UIKit

class RecommendViewModel : BaseViewModel{
    //MARK: - 懒加载属性
    lazy var cycleModels : [CycleModel ] = [CycleModel]()
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
}

//MARK:- 发送网络请求
extension RecommendViewModel{
    //请求推荐数据
     func requestData(finshCallback : @escaping () -> ()){
        //0.定义参数
        let parameters = ["limit" : "4", "offset" : "0" , "time": NSDate.getCurrentTime()]
        //2.创建Group
        let dis_group = DispatchGroup()

        //1、请求第一部分的推荐数据
        dis_group.enter()
        NetworkTools.share.getWith(url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", params: ["time":NSDate.getCurrentTime()]) { (result) in
            let yymodelmsg = YYModelMag()
            //1.将result转换成字典
            let resultDict = yymodelmsg.getDictionaryFromJSONString(jsonString: result)

            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String :NSObject]]else {return}
            //3.遍历数组，获取字典，并且将字典转成模型对象

            //3.1设置组属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dict in dataArray{
                let anchor = AnchorsModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            //3.2离开组
            dis_group.leave()
            print("请求到了0组数据")
        }error: { (error) in
            print(error)
        }

        //2、请求第二部分颜值数据
        dis_group.enter()
        NetworkTools.share.getWith(url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", params: parameters) { (result) in
            let yymodelmsg = YYModelMag()
            //1.将result转换成字典
            let resultDict = yymodelmsg.getDictionaryFromJSONString(jsonString: result)

            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String :NSObject]]else {return}
            //3.遍历数组，获取字典，并且将字典转成模型对象
            //3.1设置组属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            for dict in dataArray{
                let anchor = AnchorsModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dis_group.leave()
            print("请求到了1组数据")
        }error: { (error) in
            print(error)
        }

        //3、请求第三部分游戏数据
        dis_group.enter()
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            dis_group.leave()
        }
//        NetworkTools.share.getWith(url: "http://capi.douyucdn.cn/api/v1/getHotCate", params: parameters) { (result) in
////            print(result)
//            let yymodelmsg = YYModelMag()
//            //1.将result转换成字典
//            let resultDict = yymodelmsg.getDictionaryFromJSONString(jsonString: result)
//
//            //2.根据data该key，获取数组
//            guard let dataArray = resultDict["data"] as? [[String :NSObject]]else {return}
//            //3.遍历数组，获取字典，并且将字典转成模型对象
//            for dict in dataArray{
//                let group = AnchorGroup(dict: dict)
//                self.anchorGroups.append(group)
//            }
//            for group in self.anchorGroups{
//                for anchor in group.anchors{
//                    print(anchor.nickname)
//                }
//                print("------------")
//            }
//            dis_group.leave()
//            print("请求到了2-12组数据")
//        } error: { (error) in
//            print(error)
//        }
      //6.所有数据都请求到，之后进行排序
        dis_group.notify(queue: .main){
            print("所有数据都请求到了")
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finshCallback()
        }
    }
    
    //请求无线轮播的数据
    func  requestCycleData(finshCallback : @escaping () -> ()){
        NetworkTools.share.getWith(url: "http://www.douyutv.com/api/v1/slide/6", params: ["version":"2.300"]) { (result) in
            let yymodelmsg = YYModelMag()
            //1.将result转换成字典
            let resultDict = yymodelmsg.getDictionaryFromJSONString(jsonString: result)

            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String :NSObject]]else {return}
            
            for dict in dataArray{
                self.cycleModels.append(CycleModel(dict: dict))
            }
            finshCallback()
        }error: { (error) in
            print(error)
        }
    }
}
