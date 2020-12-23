//
//  RecommendViewModel.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/22.
//

import UIKit

class RecommendViewModel: NSObject {

}
//MARK:- 发送网络请求
extension RecommendViewModel{
    func requestData(){
        //1、请求第一部分的推荐数据
        //2、请求第二部分颜值数据

        
        //3、请求第三部分游戏数据
        let network = NetworkTools.share.postWith(url: "http//capi.douyucdn.cn/api/v1/getHotCate", params: ["limit" : "4", "offset" : "0" , "time": NSDate.getCurrentTime()]) { (result) in
            print(result)
            //1.将result转换成字典
            guard let resultDict = result as? [String :NSObject] else {return}
        } error: { (error) in
            print(error)
        }

    }
}
