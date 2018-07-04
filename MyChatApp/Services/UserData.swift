//
//  UserData.swift
//  MyChatApp
//
//  Created by hossein shademany on 2/12/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import Foundation
class UserData{
    static let instance = UserData()
    
    public private(set) var id : String = ""
    public private(set) var name : String = ""
    public private(set) var avatarColor : String = ""
    public private(set) var avatarName : String = ""
    public private(set) var email : String = ""
    
    // set user data
    func setUSerData(id: String , name: String, avatarName: String, email: String, avatarColor: String){
        self.id = id
        self.name = name
        self.email = email
        self.avatarColor = avatarColor
        self.avatarName = avatarName
    }
    //    update the name
    func updateAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
    //user avatar color
    func userColor(component : String)->UIColor{
        // "[0.925490196078431, 0.631372549019608, 0.996078431372549, 1]"
        
        let scanner = Scanner(string: component)
        
        let skip = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skip
        
        var r, b, g, a : NSString?
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor  = UIColor.lightGray
        
        guard let rUnwraped = r else{return defaultColor}
        guard let gUnwraped = g else{return defaultColor}
        guard let bUnwraped = b else{return defaultColor}
        guard let aUnwraped = a else{return defaultColor}
        
        let rFloat = CGFloat(rUnwraped.doubleValue)
        let gFloat = CGFloat(gUnwraped.doubleValue)
        let bFloat = CGFloat(bUnwraped.doubleValue)
        let aFloat = CGFloat(aUnwraped.doubleValue)
        
        let newColor = UIColor(red: rFloat/255, green: gFloat/255, blue: bFloat/255, alpha: aFloat)
        return newColor
    }
    //logout
    func logout(){
        self.id = ""
        self.name = ""
        self.avatarColor = ""
        self.avatarName = ""
        self.email = ""
        
        AuthUserService.instance.userEmail = ""
        AuthUserService.instance.authUSer = ""
        AuthUserService.instance.isLoggedIn = false
        MessageService.instance.clearChannel()
        MessageService.instance.clearMessages()
        NotificationCenter.default.post(name: NOTIF_USER_CHANGED, object: nil)
        
    }
}
