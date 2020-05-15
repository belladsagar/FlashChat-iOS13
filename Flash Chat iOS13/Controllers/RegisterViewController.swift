//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by SAGAR C BELLAD on 18/04/2020.
//  Copyright © 2019 SAGAR C BELLAD. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
       if let email = emailTextfield.text,let password = passwordTextfield.text{
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                }
                else{
                    //Navigate to the chatViewController
                    self.performSegue(withIdentifier: k.registerSegue, sender: self)
                }
            }
        }
        
    }
    
}

