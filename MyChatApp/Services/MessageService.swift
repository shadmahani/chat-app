//
//  MessageService.swift
//  MyChatApp
//
//  Created by hossein shademany on 3/13/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class MessageService{
    static var instance = MessageService()
    var channels = [Channel]()
    var selectedChannel : Channel?
    var messages = [Message]()
    //find all channels
    func findAllChannels(completion: @escaping completion){
        Alamofire.request(URL_FIND_ALL_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                guard let data = response.data else {return}
                if let json = JSON(data: data).array{
                    for item in json {
                        let name = item["name"].stringValue
                        let id = item["_id"].stringValue
                        let descreption = item["description"].stringValue
                        let channel = Channel(name: name, id: id, descreption: descreption)
                        self.channels.append(channel)
                    }
                    
                    completion(true, nil)
                }
                
            }else{
                completion(false, response.response?.statusCode)
                Logger.log(message: "\(response.result.error as Any)", event: .s )
            }
        }
    }
    // add channel
    func addChannel(channelName: String,channelDesc: String,completion: @escaping completion){
        let body : [String:Any] = [
            "name" : channelName,
            "description" : channelDesc
        ]
        Alamofire.request(URL_ADD_CHANNEL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseString { (response) in
            if response.response?.statusCode == 200 {
                completion(true, nil)
            }else{
                completion(false, response.response?.statusCode)
                Logger.log(message: "\(response.result.error as Any)", event: .s )
            }
        }
    }
 
    //get all messages
    func messageForChannle(channelId: String,completion : @escaping completion){
        Alamofire.request("\(URL_FETCH_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            guard let data = response.data else{return}
            self.clearMessages()
            if let array = JSON(data: data).array {
                for item in array {
               
                    let id = item["_id"].stringValue
                    let messageBody = item["messageBody"].stringValue
                    let userId = item["userId"].stringValue
                    let channelId = item["channelId"].stringValue
                    let userName = item["userName"].stringValue
                    let userAvatar = item["userAvatar"].stringValue
                    let userAvatarColor = item["userAvatarColor"].stringValue
                    let timeStamp = item["timeStamp"].stringValue
                    let message = Message(id: id, messageBody: messageBody, userId: userId, channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
                    self.messages.append(message)
                  
                }
                completion(true, nil)
            }else{
                completion(false, response.response?.statusCode)
                Logger.log(message: "\(response.result.error as Any)", event: .s)
            }
        }
    }
    // clear channels
    func clearChannel(){
        self.channels.removeAll()
    }
    //clear messages
    func clearMessages(){
        self.messages.removeAll()
    }
    
    
    
    
    
}
