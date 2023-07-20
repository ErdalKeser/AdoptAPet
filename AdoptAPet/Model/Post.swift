//
//  Post.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 3.07.2023.
//

import Firebase

struct Post {
    
    var caption: String
    let imageUrl: String
    let ownerUid: String
    let city: String
    let genus: String
    let timestamp: Timestamp
    let ownerImageUrl: String
    let ownerUsername: String
    
    init(dictionary: [String:Any]){
        self.caption = dictionary["caption"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.genus = dictionary["genus"] as? String ?? ""
        self.city = dictionary["city"] as? String ?? ""
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.ownerImageUrl = dictionary["ownerImageUrl"] as? String ?? ""
        self.ownerUsername = dictionary["ownerUsername"] as? String ?? ""
    }
}
