//
//  HealthGramLoginVC.swift
//  healthGram
//
//  Created by Anmol Gondara on 11/21/19.
//  Copyright © 2019 Anmol Gondara. All rights reserved.
//

import UIKit
import FirebaseAuth

class HealthGramLoginVC: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func onLogin(_ sender: Any) {
        guard let email = email.text, let password = password.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) {
            (success, error) in
            if error != nil {
                // handles error and gives an error message to the user
                print("Error: \(String(describing: error?.localizedDescription))")
                Alerts.showAlert(on: self, title: "Alert", message: error?.localizedDescription ?? "")
            }
            else {
                // when the user signs in successfully, perform segue to exercise screen
                self.performSegue(withIdentifier: "loginSegue", sender: self)
                print("User logged in")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
