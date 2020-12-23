//
//  NetworkTools.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/21.
//

import UIKit
import Alamofire
import Foundation

typealias FSResponseSuccess = (_ response: String) -> Void
typealias FSResponseFail = (_ error: String) -> Void
typealias FSNetworkStatus = (_ NetworkStatus: Int32) -> Void
typealias FSProgressBlock = (_ progress: Int32) -> Void

@objc enum NetworkStatus: Int32 {
    case unknown          = -1//未知网络
    case notReachable     = 0//网络无连接
    case wwan             = 1//2，3，4G网络
    case wifi             = 2//wifi网络
}


enum MethodType {
    case GET
    case POST
}

class NetworkTools : NSObject {
    //单例
        static let share = NetworkTools()
        private var sessionManager: Session?
        override init() {
            super.init()
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 60
            sessionManager = Session.init(configuration: configuration, delegate: SessionDelegate.init(), serverTrustManager: nil)
        }
        
        ///当前网络状态
        private var mNetworkStatus: NetworkStatus = NetworkStatus.wifi
        
        public func getWith(url: String,
                            params: [String: Any]?,
                            success: @escaping FSResponseSuccess,
                            error: @escaping FSResponseFail) {
            requestWith(url: url,
                        httpMethod: 0,
                        params: params,
                        success: success,
                        error: error)
        }
        
        public func postWith(url: String,
                             params: [String: Any]?,
                             success: @escaping FSResponseSuccess,
                             error: @escaping FSResponseFail) {
            requestWith(url: url,
                        httpMethod: 1,
                        params: params,
                        success: success,
                        error: error)
        }
        
        public func requestWith(url: String,
                                httpMethod: Int32,
                                params: [String: Any]?,
                                success: @escaping FSResponseSuccess,
                                error: @escaping FSResponseFail) {
            //get
            if httpMethod == 0 {
                manageGet(url: url, params: params, success: success, error: error)
            } else {
                managePost(url: url, params: params!, success: success, error: error)
            }
        }
        
        private func managePost(url: String,
                                params: [String: Any],
                                success: @escaping FSResponseSuccess,
                                error: @escaping FSResponseFail) {
            //请求头信息
            let header = HTTPHeaders()
//            header.add(name: "dragon-system", value: FSRequestData.share.getHeaderJson())
            AF.request(url,
                            method: .post,
                            parameters: params,
                            encoding: URLEncoding.default,
                            headers: header).responseJSON { (response) in
                                switch response.result {
                                case .success:
                                    let json = String(data: response.data!, encoding: String.Encoding.utf8)
                                    success(json ?? "")
                                case .failure:
                                    let statusCode = response.response?.statusCode
                                    error("\(statusCode ?? 0)请求失败")
                                    debugPrint(response.response as Any)
                                }
            }
        }
        
        private func manageGet(url: String,
                               params: [String: Any]?,
                               success: @escaping FSResponseSuccess,
                               error: @escaping FSResponseFail) {
            //请求头信息
            let header = HTTPHeaders()
//            header.add(name: "dragon-system", value: FSRequestData.share.getHeaderJson())
            AF.request(url,
                            method: .get,
                            parameters: params,
                            encoding: URLEncoding.default,
                            headers: header).responseJSON { (response) in
                                switch response.result {
                                case .success:
                                    let json = String(data: response.data!, encoding: String.Encoding.utf8)
                                    success(json ?? "")
                                case .failure:
                                    let statusCode = response.response?.statusCode
                                    error("\(statusCode ?? 0)请求失败")
                                    debugPrint(response.response as Any)
                                }
            }
        }
        


}



