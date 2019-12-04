//
//  CameraVC.swift
//  healthGram
//
//  Created by Sunminder Sandhu on 12/2/19.
//  Copyright © 2019 Russell Wong. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class CameraVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    
    // References to firebase database and authentication
    let dataRef = Database.database().reference()
    let auth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onPost(_ sender: Any) {
        
        // user id
        let uid = auth.currentUser?.uid
        //get convert image into Data type
        let imageData = UIImage.pngData(self.imageView.image!)
        //reference to child "photoPosts", childByAutoId creates an unique id
        let newPostRef = Database.database().reference().child("photoPosts").childByAutoId()
        //.key refers to the unique id created
        let newPostKey = newPostRef.key
        
        //storage reference to the child "images" folder
        let imageStorageRef = Storage.storage().reference().child("images")
        //reference to the specific element according to its unique id thats the same in database
        let newImageRef = imageStorageRef.child(newPostKey!)
        
        //putting data in storage
        newImageRef.putData(imageData()!, metadata: nil) {(metadata, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }else {
                //storage .downloadURL method which gives the downloadUrl
                newImageRef.downloadURL(completion: { (url, error) in
                    let imageDownloadUrl = url
                    
                    //array to store the attributes
                    let postDic = [
                        "imageUrl" : imageDownloadUrl!.absoluteString,
                        "caption" : self.captionField.text!,
                        "uid" : uid
                        ] as [String : Any]
                    
                    print("dic created")
                    
                    //save dictionary to Database
                    newPostRef.setValue(postDic)
                    print("image saved to database")
                })
                
                //self.saveImagaToFirebaseWithUid(uid: uid!, values: post)
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = (self as! UIImagePickerControllerDelegate &
            UINavigationControllerDelegate)
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let resized = resizeImage(image: image, targetSize: size)
        
        imageView.image = resized
        
        dismiss(animated: true, completion: nil)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
