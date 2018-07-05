//
//  SignUpVC.swift
//  MyChatApp
//
//  Created by hossein shademany on 2/11/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!

    @IBOutlet weak var avatarImage: UIImageView!
    
    // default properties
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    
    func config(){
        let tapOnAlertView = UITapGestureRecognizer(target: self, action: #selector(keyboradDismiss))
        view.addGestureRecognizer(tapOnAlertView)
        //spinner
        JustHUD.instance.hide()
    }
    @objc func keyboradDismiss(){
        view.endEditing(true)
    }
    // dismiss button
    @IBAction func dismissBtn(_ sender: Any) {
        performSegue(withIdentifier: UN_WIND, sender: nil)
    }
    // getting back to view
    override func viewDidAppear(_ animated: Bool) {
        if UserData.instance.avatarName != "" {
            avatarImage.image = UIImage(named: UserData.instance.avatarName)
            avatarName = UserData.instance.avatarName
            if UserData.instance.avatarName.contains("light") && bgColor == nil {
                avatarImage.backgroundColor = UIColor.darkGray
            }
        }
    }
    
    // sign up clicked
    @IBAction func signUpBtn(_ sender: Any) {
        //internet check
        guard isConnected else {
            print("internet issue!")
            return
        }
        // spinner
       JustHUD.instance.showInView(view: self.view, withHeader: nil, andFooter: "Please waite...")
        guard (email.text?.isEmailValid())! else {
            let myAlert = alert(title: "Oops!", message: "Email is not valid", actionTitle: "ok")
            self.present(myAlert, animated: true, completion: nil)
            JustHUD.instance.hide()
            return
        }
      
        if let name = userName.text , userName.text != "" , let userEmail = email.text , email.text != "" ,let userPass = pass.text , pass.text != "" {
            //validate email
            guard (email.text?.isEmailValid())! else {
                let myAlert = alert(title: "Oops!", message: "Email is not valid", actionTitle: "ok")
                self.present(myAlert, animated: true, completion: nil)
                JustHUD.instance.hide()
                return
            }
            // auth the user
            AuthUserService.instance.AuthUser(email: userEmail, pass: userPass) { (success,err) in
                if success {
                    print("user regestired!/n")
                    // login the user
                    AuthUserService.instance.loginUser(email: userEmail, password: userPass, completion: { (success,err) in
                        if success{
                            print("user logged in!")
                            // add the user
                            AuthUserService.instance.addUser(name: name, email: userEmail, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success,err) in
                                if success{
                                    
                                    print("user added!")
                                    // in the end
                                   JustHUD.instance.hide()
                                    NotificationCenter.default.post(name: NOTIF_USER_CHANGED, object: nil)
                                    //                                AuthUserService.instance.isLoggedIn = true
                                    self.performSegue(withIdentifier: UN_WIND, sender: nil)
                                }else{
                                    errorHandler(err: err, view: self,isSpinnerOn: true)
                                }
                            })
                        }else{
                            errorHandler(err: err, view: self,isSpinnerOn: true)
                        }
                    })
                }else{
                    errorHandler(err: err!, view: self,isSpinnerOn: true)
                }
            }
        }else{
            JustHUD.instance.hide()
            let myAlert = alert(title: "Oops!", message: "please fill all forms!", actionTitle: "ok")
            self.present(myAlert, animated: true, completion: nil)
        }
        
    }
    
    //generate background color
    @IBAction func generateColorpressed(_ sender: Any) {
        let red  = CGFloat(arc4random_uniform(256) + 1)
        let green = CGFloat(arc4random_uniform(256) + 1)
        let blue = CGFloat(arc4random_uniform(256) + 1)
        
        avatarImage.backgroundColor = UIColor(red: red / 255, green: green/255, blue: blue/255, alpha: 1)
         self.bgColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
         self.bgColor = avatarImage.backgroundColor
         self.avatarColor = "[\(red),\(green),\(blue),1]"
        
    }
    
    @IBAction func dismissBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
