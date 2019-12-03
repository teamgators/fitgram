//
//  HealthLabProfileVC.swift
//  healthGram
//
//  Created by Anmol Gondara on 11/22/19.
//  Copyright © 2019 Russell Wong. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class HealthLabProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    //array of Post (refer to Post.swift file)
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        Database.database().reference().child("photoPosts").observe(.childAdded) { (snapshot) in
            let newPost = Post(snapshot: snapshot)
            
            self.posts.insert(newPost, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .top)
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        
        cell.captionLabel.text = post.caption
        cell.usernameLabel.text = "Russell"
        
        print("Debug1")
        print(post.caption)
        print(post.imageDownloadUrl)
        
        if let imageDownloadUrl = post.imageDownloadUrl {
            print("Debug2")
            print("imageDownloadURL from post: ")
            print(imageDownloadUrl)
            
            let imageStorageRef = Storage.storage().reference(forURL: imageDownloadUrl)
            
            imageStorageRef.getData(maxSize: 2*1024*1024) { (data, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    return
                } else {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        cell.imageView!.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    @IBAction func onLogout(_ sender: Any) {
        let firebaseRef = Auth.auth()
        
        do {
            try firebaseRef.signOut()
            performSegue(withIdentifier: "logoutSegue", sender: self)
            print("User logged out")
        } catch let logoutError {
            print("Error: \(logoutError.localizedDescription)")
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
