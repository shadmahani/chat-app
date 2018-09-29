//
//  General.swift
//  MyChatApp
//
//  Created by hossein shademany on 3/5/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import Foundation
import Alamofire
// Colors
extension UIColor{
    class var mianColor : UIColor{
        return UIColor.blue
    }
}
// conectivity
var isConnected: Bool{
    return NetworkReachabilityManager()!.isReachable
}
// avatar type
enum AvatarType {
    case dark
    case light
}
//error handler
func errorHandler(err : Int?, vC: UIViewController,isSpinnerOn: Bool?){
    
    guard let err  = err else{return}
    switch err {
    case 503 : vC.present(alert(title: "error", message: "there is something wrong with the server, hang tide!", actionTitle: "ok"), animated: true, completion: nil)
   
        case 401 : vC.present(alert(title: "error", message: "email or password is wrong!", actionTitle: "ok"), animated: true, completion: nil)
    default:
        vC.present(alert(title: "error", message: "some thing went wrong!", actionTitle: "ok"), animated: true, completion: nil)

    }
    if isSpinnerOn! {
        JustHUD.instance.hide()
    }
}
// make alert view
func alert(title: String, message: String, actionTitle: String)->UIAlertController{
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
    return alert
}

