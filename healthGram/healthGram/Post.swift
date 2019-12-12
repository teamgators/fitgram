//
//  Post.swift
//  healthGram
//
//  Created by Russell Wong on 11/29/19.
//  Copyright © 2019 Russell Wong. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SwiftyJSON

class Post{
    
    var caption: String!
    var imageDownloadUrl: String?
    var uid: String!
    
    init(snapshot: DataSnapshot){
        let json = JSON(snapshot.value!)
        self.imageDownloadUrl = json["imageUrl"].stringValue
        self.caption = json["caption"].stringValue
        self.uid = json["uid"].stringValue
    }
    
}
