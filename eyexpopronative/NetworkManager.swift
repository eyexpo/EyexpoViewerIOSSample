//
//  File.swift
//  eyexpopronative
//
//  Created by Thompson Sanjoto on 2018-07-13.
//  Copyright © 2018 eyexpo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkManager {
    
    static let baseURL = "https://stage.eyexpo.com/"
    static let baseAPI = "api/v1/"
    static let login = baseURL + baseAPI + "users/login"
    static let publictours = baseURL + baseAPI + "users/publictours"
    static let model = baseURL + baseAPI + "users/models"
    static let panoviewer = baseURL + "panorama"
    
    static let shared = NetworkManager()
    static let header:HTTPHeaders = ["accept":"application/json"]
    
    var userInfo:UserDefaults = UserDefaults()
    var token:String? = nil
    
    
    init(){
        
    }
    
    public func login(email:String, password:String, completion:((_ err:Any?,_ succ:Any?) -> Void)? = nil){
        
        let param:Parameters = [
            "identifierType":"email",
            "identifierValue": email,
            "password":password
        ]
        Alamofire.request(NetworkManager.login, method: .post, parameters: param, headers:NetworkManager.header).responseJSON { response in
            NetworkManager.processResponse(response: response, completion: completion)
        }
    }
    
    public func getPublicTours(completion:((_ err:Any?,_ succ:Any?) -> Void)? = nil){
        let token = UserDefaults.standard.object(forKey: "token") as! String
        
        var header = NetworkManager.header
        header["Authorization"] = token
        
        Alamofire.request(NetworkManager.publictours, method: .get, headers: header).responseJSON { response in
            NetworkManager.processResponse(response: response, completion: completion)
        }
        
    }
    
    static func processResponse(response:DataResponse<Any>, completion:((_ err:Any?,_ succ:Any?) -> Void)? = nil){

        if response.response?.statusCode == 200 {
            if let cb = completion{
                cb(nil, response.result.value)
            }
        }
        else {
            if let cb = completion{
                cb(response.result.value ?? response , nil)
            }
        }
    }
}
