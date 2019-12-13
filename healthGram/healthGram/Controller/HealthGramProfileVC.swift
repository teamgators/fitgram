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

class HealthGramProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    //array of Post class objects
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        loadPosts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadPosts()
    }
    
    func loadPosts() {
        posts.removeAll()
        
        // grab data from database and insert into array
        Database.database().reference().child("photoPosts").observe(.childAdded) { (snapshot: DataSnapshot) in
            let newPost = Post(snapshot: snapshot)
            self.posts.append(newPost)
            print(self.posts)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let uid = posts[indexPath.row].uid
        // to grab user's firstName using uid, and set it to the post's usernameLabel
        Database.database().reference().child("user").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            cell.usernameLabel.text  = value?["firstName"] as? String ?? ""
            print("NAME: \(String(describing: cell.usernameLabel.text))")
        }) { (error) in
            cell.usernameLabel.text = "Unknown user"
            print(error.localizedDescription)
        }
        
        cell.captionLabel.text = posts[indexPath.row].caption
        let imageUrl = posts[indexPath.row].imageDownloadUrl
        print("imageUrl: \(String(describing: imageUrl))")
        
        let imageStorageRef = Storage.storage().reference(forURL: imageUrl!)
        
        // grab image from Storage
        imageStorageRef.getData(maxSize: 2*1024*1024) { (data, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            } else {
                // set image
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    cell.imageView!.image = image
                }
            }
        }
        
        return cell
    }
    
    // Logout button
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
    
}
