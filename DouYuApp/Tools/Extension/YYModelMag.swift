//
//  YYModelMag.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/24.
//

import Foundation

class YYModelMag: NSObject {
    
    func convertJSONStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.init(rawValue: 0)]) as? [String:AnyObject]
            } catch let error as NSError {
                 print(error)
            }
        }
        return nil
    }
    
    func convertDictionaryToJSONString(dict:NSDictionary?)->String {
        let data = try? JSONSerialization.data(withJSONObject: dict!, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        return jsonStr! as String
    }
    // JSONString转换为字典
    public func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        let jsonData:Data = jsonString.data(using: .utf8)!
     
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
         
     
    }

}
