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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.exercises.removeAll()
        
        dataRef.child("exercises").child("exerciseList").queryOrderedByKey().observeSingleEvent(of: .value) { (snapshot) in
            if let snapValues = snapshot.children.allObjects as? [DataSnapshot] {
                for value in snapValues {
                    if let mainValue = value.value as? [String : AnyObject] {
                        let exerciseType = mainValue["part"] as? String
                        let exerciseName = mainValue["name"] as? String
                        let exerciseEquipment = mainValue["equipment"] as? String
                        let exerciseInstructions = mainValue["instructions"] as? String
                        self.exercises.append(ExercisePost(name: exerciseName!, equipment: exerciseEquipment!, part: exerciseType!, instructions: exerciseInstructions!))
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell") as! ExerciseCell
        let exercise = exercises[indexPath.row]
        
        cell.exerciseTypeLabel.text = exercise.part
        cell.exerciseNameLabel.text = exercise.name
        cell.equipmentLabel.text = exercise.equipment
        
        return cell
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let exerciseInfo = exercises[(indexPath?.row)!]
        
        let exerciseInfoVC = segue.destination as! HealthLabExerciseInfoVC
        exerciseInfoVC.exerciseInstructions = exerciseInfo.instructions
        exerciseInfoVC.exerciseName = exerciseInfo.name
        tableView.deselectRow(at: indexPath!, animated: true)
        tableView.reloadData()
    }
    

}
