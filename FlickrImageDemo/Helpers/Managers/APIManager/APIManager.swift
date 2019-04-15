//
//  APIManager.swift
//  Mirror
//
//  Created by Shailesh Tyagi on 03/08/17.
//  Copyright © 2017 huulke. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIManager: NSObject {

    class func apiGet(serviceName:String,parameters: [String:Any]?, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        debugPrint(parameters ?? "Nil")
        debugPrint("API -- ",serviceName)
        Alamofire.request(serviceName, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: [Constants.ServerKey.Authorization:getAccessToken()]).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json = JSON(data)
                    if json[Constants.ServerKey.error][Constants.ServerKey.statusCode].intValue == 401 {
                        //Invalid Token
                       // UserManager.shared().deleteActiveUser()
                        UserDefaultsManager.sharedInstance.clearCache()
                    }
                    completionHandler(json,nil)
                }
                break
                
            case .failure(_):
                completionHandler(nil,response.result.error as NSError?)
                break
                
            }
        }
    }
    
    class func apiPost(serviceName:String,parameters: [String:Any]?, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        debugPrint(parameters ?? "Nil")
        debugPrint("API -- ",serviceName)
        Alamofire.request(serviceName, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: [Constants.ServerKey.Authorization:getAccessToken()]).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json = JSON(data)
                    if json[Constants.ServerKey.error][Constants.ServerKey.statusCode].intValue == 401 {
                        //Invalid Token
                       // UserManager.shared().deleteActiveUser()
                        UserDefaultsManager.sharedInstance.clearCache()
                    }
                    completionHandler(json,nil)
                }
                break
                
            case .failure(_):
                completionHandler(nil,response.result.error as NSError?)
                break
                
            }
        }
    }
    
    class func apiPostWithJSONEncode(serviceName:String,parameters: [String:Any]?, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        debugPrint(parameters ?? "Nil")
        debugPrint("API -- ",serviceName)
        Alamofire.request(serviceName, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [Constants.ServerKey.Authorization:getAccessToken()]).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json = JSON(data)
                    if json[Constants.ServerKey.error][Constants.ServerKey.statusCode].intValue == 401 {
                        //Invalid Token
                       // UserManager.shared().deleteActiveUser()
                        UserDefaultsManager.sharedInstance.clearCache()
                    }
                    completionHandler(json,nil)
                }
                break
                
            case .failure(_):
                completionHandler(nil,response.result.error as NSError?)
                break
                
            }
        }
    }
    
    class func apiPut(serviceName:String,parameters: [String:Any]?, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        debugPrint(parameters ?? "Nil")
        debugPrint("API -- ",serviceName)
        Alamofire.request(serviceName, method: .put, parameters: parameters, encoding: URLEncoding.default, headers: [Constants.ServerKey.Authorization:getAccessToken()]).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json = JSON(data)
                    if json[Constants.ServerKey.error][Constants.ServerKey.statusCode].intValue == 401 {
                        //Invalid Token
                      //  UserManager.shared().deleteActiveUser()
                        UserDefaultsManager.sharedInstance.clearCache()
                    }
                    completionHandler(json,nil)
                }
                break
                
            case .failure(_):
                completionHandler(nil,response.result.error as NSError?)
                break
                
            }
        }
    }
    
    class func apiDelete(serviceName:String,parameters: [String:Any]?, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        debugPrint(parameters ?? "Nil")
        debugPrint("API -- ",serviceName)
        Alamofire.request(serviceName, method: .delete, parameters: parameters, encoding: URLEncoding.default, headers: [Constants.ServerKey.Authorization:getAccessToken()]).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json = JSON(data)
                    if json[Constants.ServerKey.error][Constants.ServerKey.statusCode].intValue == 401 {
                        //Invalid Token
                       // UserManager.shared().deleteActiveUser()
                        UserDefaultsManager.sharedInstance.clearCache()
                    }
                    completionHandler(json,nil)
                }
                break
                
            case .failure(_):
                completionHandler(nil,response.result.error as NSError?)
                break
                
            }
        }
    }

    
    class func apiMultipart(serviceName:String,parameters: [String:Any]?, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        debugPrint(parameters ?? "Nil")
        debugPrint("API -- ",serviceName)
        Alamofire.upload(multipartFormData: { (multipartFormData:MultipartFormData) in
            for (key, value) in parameters! {
                if key == "picture" {
                    multipartFormData.append(
                        value as! Data,
                        withName: key,
                        fileName: "profileImage.jpg",
                        mimeType: "image/jpg"
                    )
                } else {
                    //multipartFormData
                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                }
            }
        }, usingThreshold: 1, to: serviceName, method: .post, headers: [Constants.ServerKey.Authorization:getAccessToken()]) { (encodingResult:SessionManager.MultipartFormDataEncodingResult) in
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if response.result.error != nil {
                        completionHandler(nil,response.result.error as NSError?)
                        return
                    }
                    if let data = response.result.value {
                        let json = JSON(data)
                        if json[Constants.ServerKey.error][Constants.ServerKey.statusCode].intValue == 401 {
                            //Invalid Token
                           // UserManager.shared().deleteActiveUser()
                            UserDefaultsManager.sharedInstance.clearCache()
                        }
                        completionHandler(json,nil)
                    }
                }
                break
                
            case .failure(let encodingError):
                print(encodingError)
                completionHandler(nil,encodingError as NSError?)
                break
            }
        }
    }
    
    class func getAccessToken() -> String {
        if let token = UserDefaultsManager.sharedInstance.accessToken as? String {
            return "Bearer " + token
        }
        return ""
    }
}
