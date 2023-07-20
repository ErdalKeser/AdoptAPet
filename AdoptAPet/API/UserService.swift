//
//  UserService.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 3.07.2023.
//

import Firebase

struct UserService {
    
    static func fetchUser(withUid uid: String ,completion: @escaping(User)->(Void)) {
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
}
