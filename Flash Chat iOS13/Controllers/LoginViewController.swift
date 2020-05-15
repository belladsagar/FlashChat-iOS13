//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by SAGAR C BELLAD on 18/04/2020.
//  Copyright © 2019 SAGAR C BELLAD. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text,let password = passwordTextfield.text{
            
            Auth.auth().signIn(withEmail: email, password: password) {authResult,error in
                if let e = error{
                    print(e)
                }
                else{
                    self.performSegue(withIdentifier: k.loginSegue, sender: self)
                }
            }
            
        }
        
    }
    
}
