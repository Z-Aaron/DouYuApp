//
//  AmuseViewModel.swift
//  DouYuApp
//
//  Created by mamini on 2021/1/12.
//

import UIKit

class AmuseViewModel: NSObject {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}
extension AmuseViewModel{
    func loadAmiseData(finishedCallback : @escaping()->()) {
        NetworkTools.share.getWith(url: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", params: nil) { (result) in
            
                let yymodelmsg = YYModelMag()
            
                //1.将result转换成字典
                let resultDict = yymodelmsg.getDictionaryFromJSONString(jsonString: result)

                //2.根据data该key，获取数组
                guard let dataArray = resultDict["data"] as? [[String :NSObject]]else {return}
                //3.遍历数组，获取字典，并且将字典转成模型对象
                for dict in dataArray{
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
                //4.完成回调
                finishedCallback()
            }error: { (error) in
                print(error)
            }
    }
}

