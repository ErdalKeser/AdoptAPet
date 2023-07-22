//
//  FeedVM.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 21.07.2023.
//

import Foundation

class FeedVM {
    
    
    weak var delegate:FeedControllerProtocol?
    
    func fetchPosts(genus:String,city:String){
        
        PostService.fetchFeedPosts(genus: genus, city: city) { post in
            
            self.delegate?.sendPost(post: post)
        }
        
    }
    
}
