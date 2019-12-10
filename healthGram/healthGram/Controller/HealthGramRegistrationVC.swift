//
//  HealthGramRegistrationVC.swift
//  healthGram
//
//  Created by Sunminder Sandhu on 12/3/19.
//  Copyright © 2019 Russell Wong. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HealthGramRegistrationVC: UIViewController {

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
        guard let email = emailField.text, let password = passwordField.text else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (success, error) in
            if error != nil {
                // handle error, throw error message to user
                print("Error: \(String(describing: error?.localizedDescription))")
                Alerts.showAlert(on: self, title: "Alert", message: error?.localizedDescription ?? "")
            }else {
                // success, user created new account. Perform segue to exercise screen
                // perform segue here
                let dataRef = Database.database().reference()
                let userUid = Auth.auth().currentUser?.uid
                let user = [
                    "firstName" : self.firstNameField.text!,
                    "lastName" : self.lastNameField.text!,
                    "email" : self.emailField.text!
                    ] as [String : Any]
                
                dataRef.child("user").child(userUid!).setValue(user)
                self.performSegue(withIdentifier: "registrationSegue", sender: self )
                print("New Account created")
            }
        }
    }
}
