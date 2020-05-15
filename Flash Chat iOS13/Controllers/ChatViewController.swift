//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by SAGAR C BELLAD on 18/04/2020.
//  Copyright © 2019 SAGAR C BELLAD. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        navigationItem.title = k.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: k.cellNibName, bundle: nil), forCellReuseIdentifier: k.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages(){
        
        db.collection(k.FStore.collectionName)
            .order(by: k.FStore.dateField)  //sorting according to dates
            .addSnapshotListener { (quarySnapshot, error) in    //adding new messages
                self.messages = []
                if let e = error{
                    print("There was an issue retriveing  data from the Firestore \(e)")
                }else{
                    if let snapShotDocuments = quarySnapshot?.documents{
                        for doc in snapShotDocuments{
                            let data = doc.data()
                            if let messageSender = data[k.FStore.senderField] as? String,let messageBody = data[k.FStore.bodyField] as? String{
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                }
                            }
                        }
                    }
                }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text,let messageSender = Auth.auth().currentUser?.email{
            db.collection(k.FStore.collectionName).addDocument(data: [
                k.FStore.senderField: messageSender,
                k.FStore.bodyField: messageBody,
                k.FStore.dateField: Date().timeIntervalSince1970    //sorting the messages
            ]) { (error) in
                if let e = error{
                    print("There was an issue saving the data to the Firestore \(e)")
                }
                else{
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                    print("Sucess")
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
}

extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: k.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        //this is a message from the current user
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: k.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: k.BrandColors.purple)
        }
            //this is a message from the other user
        else{
            cell.rightImageView.isHidden = true
            cell.leftImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: k.BrandColors.purple)
            cell.label.textColor = UIColor(named: k.BrandColors.lightPurple)
        }
        
        
        return cell
    }
}


