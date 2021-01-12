//
//  GameViewModel.swift
//  DouYuApp
//
//  Created by mamini on 2021/1/12.
//

import UIKit

class GameViewModel: NSObject {
    lazy var games : [GameModel] = [GameModel]()
}
extension GameViewModel{
    func loadAllGameData(finishedCallback : @escaping () -> ())  {
        NetworkTools.share.getWith(url: "http://capi.douyucdn.cn/api/v1/getColumnDetail", params: ["short": "game"]) { (result) in
                let yymodelmsg = YYModelMag()
                //1.将result转换成字典
                let resultDict = yymodelmsg.getDictionaryFromJSONString(jsonString: result)

                //2.根据data该key，获取数组
                guard let dataArray = resultDict["data"] as? [[String :NSObject]]else {return}
                //3.遍历数组，获取字典，并且将字典转成模型对象
                for dict in dataArray{
                    self.games.append(GameModel(dict: dict))
                }
                //4.完成回调
                finishedCallback()
            }error: { (error) in
                print(error)
            }
    }
}

