//
//  FunnyViewModel.swift
//  DouYuApp
//
//  Created by mamini on 2021/1/15.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}
extension FunnyViewModel{
     func loadFunntData(finshedCallback :@escaping ()->()){
        loadAnchorData(isGroupData: false,URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30,"offset": 0 ], finishedCallback: finshedCallback)
    }
}
