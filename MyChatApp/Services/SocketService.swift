//
//  SocketService.swift
//  MyChatApp
//
//  Created by hossein shademany on 3/14/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import UIKit
import SocketIO
class SocketService: NSObject {

    static let instance = SocketService()
    
    override init(){
        super.init()
    }
    let socket : SocketIOClient = SocketIOClient(socketURL:URL(string: URL_BASE)!)
    // start
    func connect(){
        socket.connect()
    }
    //end
    func disconnect(){
        socket.disconnect()
    }
    
    // addChannels
    func addChannel(name: String , desc: String, completion : @escaping completion){
        socket.emit("newChannel", name, desc)
        completion(true, nil)
    }
    // get channels
    func getChannel(completion : @escaping completion){
        socket.on("channelCreated") { (dataAray, ack) in
            guard let name = dataAray[0] as? String else{return}
            guard let desc = dataAray[1] as? String else{return}
            guard let id = dataAray[2] as? String else{return}
            let channels = Channel(name: name, id: id, descreption: desc)
            MessageService.instance.channels.append(channels)
            completion(true, nil)
        }
    }
    // send message
    func sendMessage(messageBody : String,userId : String, channelId: String,userName: String, avatarName: String, avatarColor: String,completion: @escaping completion){
        socket.emit("newMessage", messageBody,userId,channelId,userName,avatarName,avatarColor)
        completion(true, nil)
    }
    
    // resive message
    func getMessage(completion : @escaping completion){
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messageBody = dataArray[0] as? String else{return}
            guard let userId = dataArray[1] as? String else{return}
            guard let channelId = dataArray[2] as? String else{return}
            guard let userName = dataArray[3] as? String else{return}
            guard let userAvatar = dataArray[4] as? String else{return}
            guard let userAvatarColor = dataArray[5] as? String else{return}
            let message = Message(id: userId, messageBody: messageBody, userId: userId, channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: "2:0:0 pm")
            MessageService.instance.messages.append(message)
            completion(true, nil)
        }
    }
}



