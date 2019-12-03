//
//  HealthLabExerciseInfoVC.swift
//  healthGram
//
//  Created by Sunminder Sandhu on 12/2/19.
//  Copyright © 2019 Russell Wong. All rights reserved.
//

import UIKit

class HealthLabExerciseInfoVC: UIViewController {
    
    var exerciseInstructions: String!
    var exerciseName: String!
    var image: UIImage!

    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseInstructionsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseInstructionsTextView.text = exerciseInstructions
        exerciseNameLabel.text = exerciseName

        // Do any additional setup after loading the view.
    }
    

}
