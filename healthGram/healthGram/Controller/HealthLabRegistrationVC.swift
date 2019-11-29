//
//  HealthLabRegistrationVC.swift
//  healthGram
//
//  Created by Sunminder Sandhu on 11/21/19.
//  Copyright © 2019 Sunminder Sandhu. All rights reserved.
//

import UIKit


class HealthLabRegistrationVC: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func onNewAccount(_ sender: Any) {
     
    }
    
}
