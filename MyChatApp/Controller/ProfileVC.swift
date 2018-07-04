//
//  ProfileVC.swift
//  MyChatApp
//
//  Created by hossein shademany on 3/7/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    //Outlets
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config(){
        self.userName.text = UserData.instance.name
        self.userImage.image = UIImage(named: UserData.instance.avatarName)
        self.userImage.backgroundColor = UserData.instance.userColor(component: UserData.instance.avatarColor)
        self.userEmail.text = UserData.instance.email
    }

    @IBAction func dismissPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserData.instance.logout()
        dismiss(animated: true, completion: nil)
    }
    
}
