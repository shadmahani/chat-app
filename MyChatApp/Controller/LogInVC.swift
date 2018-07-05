//
//  LogInVC.swift
//  MyChatApp
//
//  Created by hossein shademany on 2/11/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        
    }
    
    func config(){
        let tapOnAlertView = UITapGestureRecognizer(target: self, action: #selector(keyboradDismiss))
        view.addGestureRecognizer(tapOnAlertView)
//        spinner.isHidden = true
    }
    @objc func keyboradDismiss(){
        view.endEditing(true)
    }
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        
       
        JustHUD.instance.showInView(view: self.view, withHeader: nil, andFooter: "Please waite ...")
        // data
        guard let userEmail = userName.text , (userName.text?.isEmailValid())! else {
            let myAlert = alert(title: "Oops!", message: "Email is not valid", actionTitle: "ok")
            self.present(myAlert, animated: true, completion: nil)
            JustHUD.instance.hide()
            return
        }
        guard let userPass = passWord.text , passWord.text != "" else {return}
                // login the user
                AuthUserService.instance.loginUser(email: userEmail, password: userPass, completion: { (success, err) in
                    if success{
                        //     find user by email
                        AuthUserService.instance.findUserByEail(completion: { (success, err) in
                            if success{
                               JustHUD.instance.hide()
                                NotificationCenter.default.post(name: NOTIF_USER_CHANGED, object: nil)
                                self.performSegue(withIdentifier: UN_WIND, sender: nil)
                            }else{
                                errorHandler(err: err, view: self, isSpinnerOn: true)
                            }
                        })
                    }else{
                        errorHandler(err: err!, view: self,isSpinnerOn: true)
                    }
                }
                )
        }
}


