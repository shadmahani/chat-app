//
//  AddChannelVC.swift
//  MyChatApp
//
//  Created by hossein shademany on 3/13/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    //outlets
    
   
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var channelDesc: UITextField!
    @IBOutlet weak var channelName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapOnMainView = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        mainView.addGestureRecognizer(tapOnMainView)
        let tapOnAlertView = UITapGestureRecognizer(target: self, action: #selector(keyboradDismiss))
        alertView.addGestureRecognizer(tapOnAlertView)
    }
    @objc func dismissView(){
        dismiss(animated: true, completion: nil)
    }
    @objc func keyboradDismiss(){
        alertView.endEditing(true)
    }
    
    // add channel
    @IBAction func creatChannelPressed(_ sender: Any) {
        if let name = channelName.text , channelName.text != "" , let desc = channelDesc.text , channelDesc.text != "" {
           
                SocketService.instance.addChannel(name: name, desc: desc, completion: { (success, nil) in
                    
                    self.dismiss(animated: true, completion: nil)
                })
                
          
          
        }else{
            let myAlert = alert(title: "Oops!", message: "fill all forms", actionTitle: "ok")
            self.present(myAlert, animated: true, completion: nil)
        }
    }
    @IBAction func dismissPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
