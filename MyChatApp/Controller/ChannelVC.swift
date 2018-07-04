//
//  ChannelVC.swift
//  MyChatApp
//
//  Created by hossein shademany on 2/11/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    // Outlets
    @IBOutlet weak var addChannelBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        // notifications
        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedIn), name: NOTIF_USER_CHANGED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateChannel), name: NOTIF_CHANNEL_UPDATE, object: nil)
        // listen for newChannel
        SocketService.instance.getChannel { (success, nil) in
            self.tableView.reloadData()
        }
    }
    
   
    //before execution of view
    override func viewDidAppear(_ animated: Bool) {
            if AuthUserService.instance.isLoggedIn {
                loginBtn.setTitle( UserData.instance.name, for: .normal)
                userImage.image = UIImage(named: UserData.instance.avatarName)
                userImage.backgroundColor = UserData.instance.userColor(component: UserData.instance.avatarColor)
            }else{
                userImage.image = UIImage(named: "profileDefault")
                userImage.backgroundColor = UIColor.clear
                loginBtn.setTitle("Log in", for: .normal)
            }
    }
    // when loging changed
    @objc func userLoggedIn(){
        if AuthUserService.instance.isLoggedIn {
            loginBtn.setTitle( UserData.instance.name, for: .normal)
            userImage.image = UIImage(named: UserData.instance.avatarName)
            userImage.backgroundColor = UserData.instance.userColor(component: UserData.instance.avatarColor)
        }else{
            userImage.image = UIImage(named: "profileDefault")
            userImage.backgroundColor = UIColor.clear
            loginBtn.setTitle("Log in", for: .normal)
            tableView.reloadData()
        }
    }
    //when channels resive
    @objc func updateChannel(){
        tableView.reloadData()
    }
    //add channel
    @IBAction func addChannelPressed(_ sender: Any) {
        if AuthUserService.instance.isLoggedIn{
            let addChanncelVC = AddChannelVC()
            addChanncelVC.modalPresentationStyle = .custom
            present(addChanncelVC, animated: true, completion: nil)
        }
    }
    // log in button pressed
    @IBAction func logingPressed(_ sender: Any) {
        if AuthUserService.instance.isLoggedIn{
            let profileVC = ProfileVC()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: TO_LOG_IN, sender: nil)
        }
    }
    func config(){
        //tableView setup
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "ChannelCell", bundle: nil), forCellReuseIdentifier: "tblCellId")
        //side view size
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }
    // tableView config --------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tblCellId", for: indexPath) as?  ChannelCell {
            cell.bind(channel: MessageService.instance.channels[indexPath.row])
            return cell
        }else{
            return ChannelCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        self.revealViewController().revealToggle(animated: true)
        
    }
    
}
