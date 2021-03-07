//
//  ViewController.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/1/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let request = AF.request("https://www.thesportsdb.com/api/v1/json/1/all_sports.php")
//    
//        
////        request.validate().responseDecodable(of: SportsDict.self, queue: .global(qos:.userInitiated), decoder: JSONDecoder()) { (response) in
////            if let sportsDict = response.value{
////                if let sports = sportsDict.sports{
////                    for sport in sports{
////                        //print(sport.strSport)
////                    }
////                }
////            }
////        }
//        
////        request.responseJSON { (response) in
////            switch(response.result)
////            {
////            case .success(let data):
////                if let sportsDict = data as? [String:Any]{
////                    if let arr = sportsDict["sports"] as? [Any]{
////                        for element in arr{
////                            guard let sportData = element as? [String:String] else {
////                                return
////                            }
////                            print(sportData["strSport"])
////                        }
////                    }
////                }
////
////            case .failure(let error):
////                    print(error)
////            }
////        }
    }
}

