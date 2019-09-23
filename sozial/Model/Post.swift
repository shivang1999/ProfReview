//
//  Post.swift
//  sozial
//
//  Created by Shivang Ranjan on 23/09/19.
//  Copyright © 2019 shivangcodes. All rights reserved.
//

import Foundation

class Post {
    var caption: String
    var photoUrl: String
    
    init(captionText: String, photoUrlString: String) {
        caption = captionText
        photoUrl = photoUrlString
        
    }
}
