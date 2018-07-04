//
//  MessageCell.swift
//  MyChatApp
//
//  Created by hossein shademany on 3/17/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userMessage: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    func bind(message: Message){
        userName.text = message.userName
        userMessage.text = message.messageBody
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserData.instance.userColor(component: message.userAvatarColor)
    }

    
}
