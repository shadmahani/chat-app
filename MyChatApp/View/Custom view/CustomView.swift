//
//  CustomView.swift
//  MyChatApp
//
//  Created by hossein shademany on 4/8/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import UIKit
@IBDesignable
class CustomView: UIView {


    override func layoutSubviews() {
      
        self.layer.insertSublayer(UIColor.gradient(firstColor: UIColor.firstColor, secondColor: UIColor.secondColor,view: self), at: 0)
        
    }

}

