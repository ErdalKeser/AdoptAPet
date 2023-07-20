//
//  PostService.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 3.07.2023.
//

import UIKit
import Firebase

typealias FirestoreCompletion = (Error?) -> Void

struct PostService {
    
    static func uploadPets(genus:String,city:String,caption: String, image: UIImage, user: User, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "city": city,
                        "genus": genus,
                        "imageUrl": imageUrl,
                        "ownerUid": uid,
                        "ownerImageUrl": user.profileImageUrl,
                        "ownerUsername": user.username] as [String:Any]
            
            if genus == "Cat" && city == "Adana" {
                let docRef = COLLECTİON_A1.addDocument(data: data,completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Dog" && city == "Adana" {
                let docRef = COLLECTİON_A2.addDocument(data: data,completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Other" && city == "Adana" {
                let docRef = COLLECTİON_A3.addDocument(data: data,completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Cat" && city == "Istanbul" {
                let docRef = COLLECTİON_B1.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Dog" && city == "Istanbul" {
                let docRef = COLLECTİON_B2.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Other" && city == "Istanbul" {
                let docRef = COLLECTİON_B3.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Cat" && city == "Ankara" {
                let docRef = COLLECTİON_C1.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Dog" && city == "Ankara" {
                let docRef = COLLECTİON_C2.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Other" && city == "Ankara" {
                let docRef = COLLECTİON_C3.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Cat" && city == "Mersin" {
                let docRef = COLLECTİON_D1.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Dog" && city == "Mersin" {
                let docRef = COLLECTİON_D2.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Other" && city == "Mersin" {
                let docRef = COLLECTİON_D3.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Cat" && city == "Bursa" {
                let docRef = COLLECTİON_E1.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Dog" && city == "Bursa" {
                let docRef = COLLECTİON_E2.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Other" && city == "Bursa" {
                let docRef = COLLECTİON_E3.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Cat" && city == "Diyarbakir" {
                let docRef = COLLECTİON_F1.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Dog" && city == "Diyarbakir" {
                let docRef = COLLECTİON_F2.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Other" && city == "Diyarbakir" {
                let docRef = COLLECTİON_F3.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Cat" && city == "Izmir" {
                let docRef = COLLECTİON_G1.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Dog" && city == "Izmir" {
                let docRef = COLLECTİON_G2.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Other" && city == "Izmir" {
                let docRef = COLLECTİON_G3.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Cat" && city == "Konya" {
                let docRef = COLLECTİON_K1.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Dog" && city == "Konya" {
                let docRef = COLLECTİON_K2.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Other" && city == "Konya" {
                let docRef = COLLECTİON_K3.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Cat" && city == "Samsun" {
                let docRef = COLLECTİON_L1.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Dog" && city == "Samsun" {
                let docRef = COLLECTİON_L2.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Other" && city == "Samsun" {
                let docRef = COLLECTİON_L3.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Cat" && city == "Trabzon" {
                let docRef = COLLECTİON_N1.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Dog" && city == "Trabzon" {
                let docRef = COLLECTİON_N2.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Other" && city == "Trabzon" {
                let docRef = COLLECTİON_N3.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Cat" && city == "Van" {
                let docRef = COLLECTİON_O1.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Dog" && city == "Van" {
                let docRef = COLLECTİON_O2.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }else if genus == "Other" && city == "Van" {
                let docRef = COLLECTİON_O3.addDocument(data: data, completion: completion)
                let docRefall = COLLECTİON_ALL.addDocument(data: data,completion: completion)
            }
            
        }
        
    }

    
    static func fetchFeedPosts(genus:String,city:String,completion: @escaping([Post])-> Void){
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var posts = [Post]()
        

        if genus == "All" && city == "Turkey" {
            COLLECTİON_ALL.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}

                let posts = document.map ({Post(dictionary: $0.data())})

                completion(posts)

            }
       
            
        }else if genus == "Cat" && city == "Adana" {
            COLLECTİON_A1.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                
                let posts = document.map ({Post(dictionary: $0.data())})
                
                completion(posts)
            }
            
        }
        else if genus == "Dog" && city == "Adana" {
            COLLECTİON_A2.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                
                let posts = document.map ({Post(dictionary: $0.data())})
                
                completion(posts)
            }
            
        }else if genus == "Other" && city == "Adana" {
            COLLECTİON_A3.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                
                let posts = document.map ({Post(dictionary: $0.data())})
                
                completion(posts)
            }
            
        }else if genus == "Cat" && city == "Istanbul" {
            COLLECTİON_B1.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                
                let posts = document.map ({Post(dictionary: $0.data())})
                
                completion(posts)
            }
            
        }else if genus == "Dog" && city == "Istanbul" {
            COLLECTİON_B2.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                
                let posts = document.map ({Post(dictionary: $0.data())})
                
                completion(posts)
            }
            
        }else if genus == "Other" && city == "Istanbul" {
            COLLECTİON_B3.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                
                let posts = document.map ({Post(dictionary: $0.data())})
                
                completion(posts)
            }
            
        }else if genus == "Cat" && city == "Ankara" {
            COLLECTİON_C1.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                
                let posts = document.map ({Post(dictionary: $0.data())})
                
                completion(posts)
            }
            
        }else if genus == "Dog" && city == "Ankara" {
            COLLECTİON_C2.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                
                let posts = document.map ({Post(dictionary: $0.data())})
                
                completion(posts)
            }
            
        }else if genus == "Other" && city == "Ankara" {
            COLLECTİON_C3.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                
                let posts = document.map ({Post(dictionary: $0.data())})
                
                completion(posts)
            }
            
        }else if genus == "Cat" && city == "Mersin" {
            COLLECTİON_D1.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Dog" && city == "Mersin" {
            COLLECTİON_D2.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Other" && city == "Mersin" {
            COLLECTİON_D3.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Cat" && city == "Bursa" {
            COLLECTİON_E1.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Dog" && city == "Bursa" {
            COLLECTİON_E2.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Other" && city == "Bursa" {
            COLLECTİON_E3.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Cat" && city == "Diyarbakir" {
            COLLECTİON_F1.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Dog" && city == "Diyarbakir" {
            COLLECTİON_F2.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Other" && city == "Diyarbakir" {
            COLLECTİON_F3.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Cat" && city == "Izmir" {
            COLLECTİON_G1.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Dog" && city == "Izmir" {
            COLLECTİON_G2.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Other" && city == "Izmir" {
            COLLECTİON_G3.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Cat" && city == "Konya" {
            COLLECTİON_K1.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Dog" && city == "Konya" {
            COLLECTİON_K2.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Other" && city == "Konya" {
            COLLECTİON_K3.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Cat" && city == "Samsun" {
            COLLECTİON_L1.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Dog" && city == "Samsun" {
            COLLECTİON_L2.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Other" && city == "Samsun" {
            COLLECTİON_L3.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Cat" && city == "Trabzon" {
            COLLECTİON_N1.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Dog" && city == "Trabzon" {
            COLLECTİON_N2.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Other" && city == "Trabzon" {
            COLLECTİON_N3.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Cat" && city == "Van" {
            COLLECTİON_O1.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Dog" && city == "Van" {
            COLLECTİON_O2.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }else if genus == "Other" && city == "Van" {
            COLLECTİON_O3.order(by: "timestamp",descending: true).getDocuments { snapshot, error in
                guard let document = snapshot?.documents else {return}
                let posts = document.map ({Post(dictionary: $0.data())})
                completion(posts)
            }
        }
        
         
        }
        
        
    }

    





