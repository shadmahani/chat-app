//
//  InternetCheck.swift
//  MyChatApp
//
//  Created by hossein shademany on 3/14/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import UIKit
import ReachabilitySwift
class InternetCheck: NSObject {
    
    static let instance = InternetCheck()
    let reachability = Reachability()!
    @objc func reachabilityMonitor(_ notif: Notification){
        let reachability = notif.object as! Reachability
        
        switch reachability.currentReachabilityStatus {
        case .notReachable :
            print("no internet connection")
        case .reachableViaWiFi :
            print("via Wifi")
        case .reachableViaWWAN :
            print("via celluar system")
        }
        
    }
    func startMonitoring(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityMonitor(_:)), name: ReachabilityChangedNotification, object: reachability)
        do{
            try reachability.startNotifier()
        }catch {
            print("could not start notifier")
        }
    }
    func stopMonitoring(){
        
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
    }
}
