//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit
//import AlamofireURLCache5

class NetworkManager {

    
    static let SharedInstance = NetworkManager()
    
    func request(url:String ,
                 method : Alamofire.HTTPMethod ,
                 parameters : [String : Any]? = nil ,
                 encoding : ParameterEncoding = URLEncoding.httpBody,
                 header : HTTPHeaders? = ["Authorization" : "Bearer ","Content-Type" : "application/json"],
                 viewcontroller : UIViewController? = UIViewController(),
                 completionHandler :@escaping (AFDataResponse<Any>) -> Void
    )  {
        
        #if DEBUG
        print("Method: \(method)")
        print("PATH: \(url)")
        print("Paramters: \(String(describing: parameters))")
        print("Encoding: \(encoding)")
        print("headers: \(String(describing: header))")
        #endif
        
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: header).responseJSON { (response) in
                        
            print("RESPONSE JSON: \(String(describing: response.result))")
            print("RESPONSE JSON: \(String(describing: response))")
            
            let json = JSON(response.result)
            do{
                let value = try response.result.get() as! [String : Any]
                let msg = value["message"] as? String
                let success = value["status"] as? Bool
                if !(success ?? true){
                    if let VC = viewcontroller {
                        VC.createAlert(title: "Alert!!", message: msg)
                    }
                }
            }catch{
                print("error")
            }
            
            
            if json["success"].intValue == -1 {
                
            }else{
                
                completionHandler(response)
            }
            
        }
    }
    
    
}
