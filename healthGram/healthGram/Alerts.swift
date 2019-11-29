//
//  Alerts.swift
//  healthGram
//
//  Created by Anmol Gondara on 11/25/19.
//  Copyright © 2019 Russell Wong. All rights reserved.
//

import Foundation
import UIKit

class Alerts {
    private static func alertsSetUp(on viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showAlert(on viewController: UIViewController, title: String, message: String) {
        alertsSetUp(on: viewController, title: title, message: message)
    }
}
