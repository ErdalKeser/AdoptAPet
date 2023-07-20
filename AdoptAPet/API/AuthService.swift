//
//  AuthService.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 24.06.2023.
//

import Foundation
import Firebase
import FirebaseStorage

struct AuthService {
    
    static func logUserIn(withEmail email: String, password: String, completion: @escaping (AuthDataResult?,Error?) ->Void){
        Auth.auth().signIn(withEmail:email , password: password,completion: completion)
        
    }
    
    static func registerUser(withCredential credentials: AuthCredentials, completion: @escaping(Error?)-> Void){
        
        ImageUploader.uploadImage(image: credentials.profileImage) { imageurl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) {result, error in
                if let error = error {
                    print("debug: Failed to register user \(error.localizedDescription)")
                    return
                }
                guard let uid = result?.user.uid else {return}
            
                let data: [String:Any] = ["email": credentials.email,
                                          "fullname":credentials.fullname,
                                          "profileImageUrl": imageurl,
                                          "uid": uid,
                                          "username":credentials.username]
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
                
            }
        }
    
    }
  
}
