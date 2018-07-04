//
//  roundViiew.swift
//  MyChatApp
//
//  Created by hossein shademany on 3/17/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import UIKit

class roundViiew: UIView {

    override func awakeFromNib() {
        config()
    }
    override func prepareForInterfaceBuilder() {
        config()
    }
    func config(){
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0 , height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = false
    }

}
