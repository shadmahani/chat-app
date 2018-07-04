//
//  AuthUser.swift
//  MyChatApp
//
//  Created by hossein shademany on 2/11/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class AuthUserService {
    
    static let instance = AuthUserService()
 
    // deafult properties
    var defaults = UserDefaults.standard
    var isLoggedIn : Bool {
        get{
            return defaults.bool(forKey: LOGGED_IN)
        }
        set{
            defaults.set(newValue, forKey: LOGGED_IN)
        }
    }
    var channelCount : Float {
        get {
            return defaults.float(forKey: CHANNEL_COUNT)
        }
        set {
            defaults.set(newValue, forKey: CHANNEL_COUNT)
        }
    }
    var authUSer : String {
        get {
            return defaults.value(forKey: USER_AUTH) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_AUTH)
        }
    }
    var userEmail : String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    // AuthUSer
    func AuthUser(email: String , pass: String, completion: @escaping completion){
        let lowerCaseEmail = email.lowercased()
        let body : [String: Any] = [
            "email" : lowerCaseEmail,
            "password" : pass
        ]
        Alamofire.request(URL_REG, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil{
                completion(true,response.response?.statusCode)
            }else{
                completion(false,response.response?.statusCode)
              Logger.log(message: "\(response.result.error as Any)", event: .s )
            }
        }
    }
    

    // log in user
    func loginUser(email : String , password : String , completion : @escaping completion){
        let lowercaseEmail = email.lowercased()
        let body : [String : Any] = [
            "email"  : lowercaseEmail,
            "password" : password
        ]
        Alamofire.request(URL_LOG_IN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                
                guard let data = response.data else {return}
                let json = JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authUSer = json["token"].stringValue
                self.isLoggedIn = true
                completion(true,response.response?.statusCode)
                
            }else{
                completion(false,response.response?.statusCode)
               Logger.log(message: "\(response.result.error as Any)", event: .s )
            }
        }
    }
    // add user
    func addUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping completion){
        let lowercaseEmail = email.lowercased()
        let body : [String : Any] = [
            "email"  : lowercaseEmail,
            "name" : name,
            "avatarName" : avatarName,
            "avatarColor" : avatarColor
        ]
        Alamofire.request(URL_ADD_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                guard let data = response.data else{return}
                self.getUserData(data: data)
                
                completion(true, response.response?.statusCode)
            }else{
             Logger.log(message: "\(response.result.error as Any)", event: .s )
                completion(false,response.response?.statusCode)
            }
        }
        
    }
    // find user by email
    
    /// <#Description#>
    ///
    /// - Parameter completion: <#completion description#>
    func findUserByEail(completion: @escaping completion){
    
        Alamofire.request("\(URL_FIND_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                guard let data = response.data else{return}
                self.getUserData(data: data)
                completion(true, response.response?.statusCode)
            }else{
                completion(false, response.response?.statusCode)
               Logger.log(message: "\(response.result.error as Any)", event: .s )
           }
       }
    }
    
    // get user data
    
    /// test
    ///
    /// - Parameter data: dfdf
    func getUserData(data: Data){
        let json = JSON(data: data)
        let id = json["_id"].stringValue
        let name = json["name"].stringValue
        let email = json["email"].stringValue
        let avatarName = json["avatarName"].stringValue
        let avatarColor = json["avatarColor"].stringValue
        
        UserData.instance.setUSerData(id: id, name: name, avatarName: avatarName, email: email, avatarColor: avatarColor)
    }
    
    
}
