//
//  avatarCell.swift
//  MyChatApp
//
//  Created by hossein shademany on 2/12/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    // outlets
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    setup()
    }
    
    func bind(index : Int , avatarType: AvatarType){
        if avatarType == .dark {
            avatarImage.image = UIImage(named:"dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }else{
            avatarImage.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func setup(){
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

}
