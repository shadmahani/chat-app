//
//  ChannelCell.swift
//  MyChatApp
//
//  Created by hossein shademany on 3/13/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    //outlets
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.5).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    func bind(channel: Channel){
        label.text = "#\(channel.name ?? "")"
    }
    
}
