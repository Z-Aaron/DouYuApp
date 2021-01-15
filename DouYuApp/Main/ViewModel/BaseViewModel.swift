//
//  BaseViewModel.swift
//  DouYuApp
//
//  Created by mamini on 2021/1/13.
//

import UIKit

class BaseViewModel  {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}
extension BaseViewModel{
    func loadAnchorData(isGroupData :Bool ,URLString : String , parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()){
        NetworkTools.share.getWith(url: URLString, params: parameters) { (result) in
                let yymodelmsg = YYModelMag()
                //1.将result转换成字典
                let resultDict = yymodelmsg.getDictionaryFromJSONString(jsonString: result)
                //2.根据data该key，获取数组
                guard let dataArray = resultDict["data"] as? [[String :NSObject]]else {return}
            
                //判断是否为分组数据
                if isGroupData{
                        //3.遍历数组，获取字典，并且将字典转成模型对象
                        for dict in dataArray{
                            self.anchorGroups.append(AnchorGroup(dict: dict))
                        }
                
                    }else{
                        //创建组
                        let group = AnchorGroup()
                        
                        //遍历dataArray的所有的字典
                        for dict in dataArray{
                            group.anchors.append(AnchorsModel(dict: dict))
                        }
                        //将group，添加到anchorGroups
                        self.anchorGroups.append(group)
                    }
                    //4.完成回调
                    finishedCallback()
            }error: { (error) in
                print(error)
            }
    }
}
