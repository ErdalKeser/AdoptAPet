//
//  PostModel.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 6.07.2023.
//

import UIKit

struct PostViewModel {
    var post: Post
    
    var imageUrl: URL? {
        return URL(string: post.imageUrl)
    }
    var userProfileImageUrl: URL? {
        return URL(string: post.ownerImageUrl)
    }
    var username: String? {
        return post.ownerUsername
    }
    var caption: String {
        return post.caption
    }
   
    var timestampString: String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: post.timestamp.dateValue())
    }

    init(post: Post) {
        self.post = post
    }
}
