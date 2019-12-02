//
//  ExercisePost.swift
//  healthGram
//
//  Created by Russell Wong on 11/29/19.
//  Copyright © 2019 Russell Wong. All rights reserved.
//

import Foundation
import UIKit

class ExercisePost{
    let name: String
    let equipment: String
    let part: String
    let instructions: String
    
    init(name: String, equipment: String, part: String, instructions: String) {
        self.name = name
        self.equipment = equipment
        self.part = part
        self.instructions = instructions
    }
}
