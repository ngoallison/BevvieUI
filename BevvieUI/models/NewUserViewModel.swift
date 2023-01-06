//
//  UserViewModel.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/15/22.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class NewUserViewModel: ObservableObject {
    
    static func createNewUser(username: String, email: String, user_icon: String) {
        
        print("creating new users!")
        
        let db = Firestore.firestore()
        
        if username != "" && email != "" {
            
            let level: Int = 0
            let experience: Int = 0
            let achievements: [String] = []
            let numbevs: Int = 0
            let uid: String = Auth.auth().currentUser!.uid
            let icon: String = user_icon
                        
            db.collection("user").addDocument(data: ["username": username, "email": email, "uid": uid, "level": level, "experience": experience, "achievements": achievements, "numbevs": numbevs, "icon": icon])
            { (error) in
                if error != nil {
                    print("there was an error!")
                } else {
                    print("added new users!")
                }
            }
        }
    }
}
