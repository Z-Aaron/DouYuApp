//
//  ViewController.swift
//  DouYuApp
//
//  Created by mamini on 2020/12/10.
//

import UIKit
import Alamofire
class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = UIColor.clear
        let integerToDescribe = 5
        var description = "The number \(integerToDescribe) is"
        switch integerToDescribe {
        case 2, 3, 5, 7, 11, 13, 17, 19:
            description += " a prime number, and also"
            fallthrough
        default:
            description += " an integer."
        }
        
        print(description)



    }
    
    func dasd(data:String ,sig : Int = 1) {
        print(data,sig)
    }
}

