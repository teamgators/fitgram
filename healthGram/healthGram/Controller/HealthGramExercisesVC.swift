//
//  HealthGramExercisesVC.swift
//  healthGram
//
//  Created by Anmol Gondara on 11/22/19.
//  Copyright © 2019 Russell Wong. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HealthGramExercisesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    // store exercises here
    var exercises = [ExercisePost]()
    // reference to database
    let dataRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell") as! ExerciseCell
        let exercise = exercises[indexPath.row]
        
        cell.exerciseTypeLabel.text = exercise.part
        cell.exerciseNameLabel.text = exercise.name
        cell.equipmentLabel.text = exercise.equipment
        
        return cell
        
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
