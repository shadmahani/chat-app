//
//  Message.swift
//  MyChatApp
//
//  Created by hossein shademany on 3/17/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import Foundation
struct Message {
    public private(set) var id: String
    public private(set) var messageBody: String
    public private(set) var userId: String
    public private(set) var channelId: String
    public private(set) var userName: String
    public private(set) var userAvatar: String
    public private(set) var userAvatarColor: String
    public private(set) var timeStamp: String
}
