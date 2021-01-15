//
//  AmuseViewModel.swift
//  DouYuApp
//
//  Created by mamini on 2021/1/12.
//

import UIKit

class AmuseViewModel: BaseViewModel {
}
extension AmuseViewModel{
    func loadAmiseData(finishedCallback : @escaping()->()) {
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: nil, finishedCallback: finishedCallback)
    }
}

