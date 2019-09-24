//
//  Post.swift
//  sozial
//
//  Created by Shivang Ranjan on 23/09/19.
//  Copyright © 2019 shivangcodes. All rights reserved.
//

import Foundation

class Post {
    var caption: String?
    var photoUrl: String?

}

extension Post {
    static func transformPost(dict: [String:Any]) -> Post {
        let post = Post()
        
        
        post.caption = dict["caption"] as? String
        post.photoUrl = dict["photoUrl"] as? String
        return post
    }
}

