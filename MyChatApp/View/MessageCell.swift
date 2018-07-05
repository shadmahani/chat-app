//
//  MessageCell.swift
//  MyChatApp
//
//  Created by hossein shademany on 3/17/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var rightConstrain: NSLayoutConstraint!
    @IBOutlet weak var containerView: roundViiew!
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
        userImage.backgroundColor = UserData.instance.userColor (component: message.userAvatarColor)
        userMessage.preferredMaxLayoutWidth = 200
//        rightConstrain.constant = -textSize(text: userMessage.text!).width
    }
//    private func textSize(text: String)->CGRect {
//     let size = CGSize(width: 50, height: 1)
//        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//        return NSString(string: text).boundingRect(with: size, options: option, attributes: nil, context: nil)
//    }
    
}
