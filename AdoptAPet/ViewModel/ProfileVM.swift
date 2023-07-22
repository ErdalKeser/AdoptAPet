//
//  ProfileVM.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 21.07.2023.
//

import Foundation
import Firebase

class ProfileVM {
    
    
    weak var delegate:ProfileControllerProtocol?
    
    func fetchPost(){
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let query = COLLECTİON_ALL.whereField("ownerUid", isEqualTo: uid)
                    query.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {return}
            
            var post = documents.map({Post(dictionary: $0.data())})
            
            post.sort(by: { $0.timestamp.seconds > $1.timestamp.seconds })
            
            self.delegate?.sendPost(post: post)
//            self.posts = post
        }
        
       
        
//        PostService.fetchFeedPosts(genus: genus, city: city) { post in
//
//            self.delegate?.sendType(post: post)
//        }
        
    }
    func fetchUser(){
        
            guard let uid = Auth.auth().currentUser?.uid else {return}
            let query = COLLECTİON_ALL.whereField("ownerUid", isEqualTo: uid)
            
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            
            guard let dictionary = snapshot?.data() else { return }
            self.delegate?.sendUser(user: User(dictionary: dictionary))
            
        }
            
        }
    
}
