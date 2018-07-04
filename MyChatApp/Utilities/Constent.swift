//
//  Constent.swift
//  MyChatApp
//
//  Created by hossein shademany on 2/11/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import Foundation
typealias completion = (_ Success: Bool, _ err: Int? )->()
//URLs
let URL_BASE = "https://hossein1.herokuapp.com/v1/"
let URL_REG = "\(URL_BASE)account/register"
let URL_LOG_IN = "\(URL_BASE)account/login"
let URL_ADD_USER = "\(URL_BASE)user/add"
let URL_FIND_USER_BY_EMAIL = "\(URL_BASE)/user/byEmail/"
let URL_FIND_ALL_CHANNELS = "\(URL_BASE)channel"
let URL_ADD_CHANNEL = "\(URL_BASE)channel/add"
let URL_FETCH_MESSAGES = "\(URL_BASE)message/byChannel/"

// segue
let UN_WIND = "unwindToChatVC"
let TO_LOG_IN = "toLogIn"

// notification
let NOTIF_USER_CHANGED = Notification.Name("notifUserChanged")
let NOTIF_CHANNEL_UPDATE = Notification.Name("notifChannelUpdate")
let NOTIF_CHANNEL_SELECTED = Notification.Name("notifChannelSelected")

// key
let LOGGED_IN = "loggedIn"
let USER_EMAIL = "userEmail"
let USER_AUTH = "UserAuth"
let CHANNEL_COUNT = "channelCount"

//Headers
let HEADER : [String : String] = [
    "Content-Type" : "application/json; charset=utf-8"
]
let BEARER_HEADER : [String : String] = [
    "Authorization" : "Bearer \(AuthUserService.instance.authUSer)",
    "Content-Type" : "application/json; charset=utf-8"
    
]






