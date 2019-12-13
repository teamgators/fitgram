//
//  File.swift
//  healthGram
//
//  Created by Russell Wong on 12/12/19.
//  Copyright © 2019 Russell Wong. All rights reserved.
//

import Foundation

class PhotoPost {
    var caption: String
    var photoUrl: String
    
    init(captionText: String, photoUrlString: String){
        caption = captionText
        photoUrl = photoUrlString
    }
}
