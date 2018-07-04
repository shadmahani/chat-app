//
//  ChatVC.swift
//  MyChatApp
//
//  Created by hossein shademany on 2/11/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import UIKit

class ChatVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //outlets
    @IBAction func prepearForUnwind(segue: UIStoryboardSegue){}
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var channelNameLbl: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
      

        navigationConfig()
        // Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(changeUserData(_:)), name: NOTIF_USER_CHANGED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedChannel), name: NOTIF_CHANNEL_SELECTED, object: nil)
        //Listen for new message
        SocketService.instance.getMessage { (success, err) in
            if success{
                self.tableView.reloadData()
                self.scrollToEnd(animation: true)
            }
        }
        // find user data
        if AuthUserService.instance.isLoggedIn{
            AuthUserService.instance.findUserByEail(completion: { (success, err) in
                NotificationCenter.default.post(name: NOTIF_USER_CHANGED, object: nil)
            })
            self.channelNameLbl.setTitle(MessageService.instance.selectedChannel?.name, for: .normal)
        }else{
            channelNameLbl.setTitle("please Log in", for: .normal)
        }
    }
    @objc func updateSelectedChannel(){
           self.channelNameLbl.setTitle(MessageService.instance.selectedChannel?.name, for: .normal)
        guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        MessageService.instance.messageForChannle(channelId: channelId, completion: { (success, err) in
            self.tableView.reloadData()
            if MessageService.instance.messages.count > 0 {
                  self.scrollToEnd(animation: false)
            }
        })
    }
    @objc func keyboradDismiss(){
        view.endEditing(true)
    }

    @objc func changeUserData(_ notif: Notification){
        if AuthUserService.instance.isLoggedIn{
            //fetch channels
            MessageService.instance.findAllChannels{ (success, err) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_CHANNEL_UPDATE, object: nil)
                    // default selected channel
                    if !MessageService.instance.channels.isEmpty {
                        let channel = MessageService.instance.channels
                        MessageService.instance.selectedChannel = channel.first
                        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
                    }
                    //fetch messages
                    guard let channelId = MessageService.instance.selectedChannel?.id else {return}
                    MessageService.instance.messageForChannle(channelId: channelId, completion: { (success, err) in
                        
                        if success{
                            self.tableView.reloadData()
                            self.scrollToEnd(animation: false)
                            JustHUD.instance.hide()
                            
                        }
                    })
                }
            }
           
        }else{
           self.tableView.reloadData()
            channelNameLbl.setTitle("Please Log in", for: .normal) 
        }
    }
    func scrollToEnd(animation : Bool){
        let indexEnd = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
        self.tableView.scrollToRow(at: indexEnd, at: .bottom, animated: animation)
    }
    @IBAction func sendMessagePressed(_ sender: Any) {
        if let messageTxt = textField.text , textField.text != "" {
            SocketService.instance.sendMessage(messageBody: messageTxt, userId:UserData.instance.id , channelId: (MessageService.instance.selectedChannel?.id)! , userName: UserData.instance.name , avatarName: UserData.instance.avatarName , avatarColor: UserData.instance.avatarColor , completion: { (success, err) in
                self.textField.text = ""
            })
        }
    }
    func config(){
        // navigationBar
        let colors = [UIColor.firstColor,UIColor.secondColor]
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        navigationController?.navigationBar.isTranslucent = false
        view.bindToKeyboard()
        // Gestures
        let tapOnAlertView = UITapGestureRecognizer(target: self, action: #selector(keyboradDismiss))
        view.addGestureRecognizer(tapOnAlertView)
        // loading view
        if AuthUserService.instance.isLoggedIn {
            JustHUD.instance.showInView(view: self.view, withHeader: nil, andFooter: "Please waite...")
        }
        //tableView setup
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "messageCellId")
        //swrevreveal config
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    // navigation ---------
    func navigationConfig(){
        //left
        let burgerBtn = UIButton(type: .system)
        burgerBtn.tintColor = UIColor.white
        burgerBtn.setImage(#imageLiteral(resourceName: "smackBurger"), for: .normal)
        burgerBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: burgerBtn)
    }
    //table view config---------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCellId",for: indexPath) as? MessageCell {
            cell.bind(message: MessageService.instance.messages[indexPath.row])
            return cell
        }else{
            return MessageCell()
        }
    }
    //-----------
}
