//
//  NetworkLayer.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/5/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import Foundation
import Alamofire

class NetworkLayer{
    public static func fetchData(from urlStr:String,onCompletion handler : ((Any?,AFError?)->())?){
        let request = AF.request(urlStr)
        
        request.responseJSON { (response) in
            switch response.result{
            case .success(let data):
                handler?(data,nil)
                
                
            case .failure(let error):
                handler?(nil,error)
            }
        }
    }
}
