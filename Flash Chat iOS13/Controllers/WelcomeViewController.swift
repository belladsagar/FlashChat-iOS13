//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by SAGAR C BELLAD on 18/04/2020.
//  Copyright © 2019 SAGAR C BELLAD. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = k.appName
        for letter in titleText{
            Timer.scheduledTimer(withTimeInterval: 0.1*charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
        
    }
}
