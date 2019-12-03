//
//  Button.swift
//  healthGram
//
//  Created by Anmol Gondara on 12/2/19.
//  Copyright © 2019 Russell Wong. All rights reserved.
//

import UIKit

class Button: UIButton {
    override func didMoveToWindow() {
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
    }
}
