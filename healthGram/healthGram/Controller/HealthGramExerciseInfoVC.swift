//
//  HealthGramExerciseInfoVC.swift
//  healthGram
//
//  Created by Sunminder Sandhu on 12/3/19.
//  Copyright © 2019 Russell Wong. All rights reserved.
//

import UIKit

class HealthGramExerciseInfoVC: UIViewController {
    
    var exerciseInstructions: String!
    var exerciseName: String!
    var image: UIImage!
    
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseInstructionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseInstructionTextView.text = exerciseInstructions
        exerciseNameLabel.text = exerciseName
        // Do any additional setup after loading the view.
    }
    

}
