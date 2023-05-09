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
    
    static func createNewUserAnalytics() {
        
        print("creating new users analytics!")
        
        let db = Firestore.firestore()
    
        let uid: String = Auth.auth().currentUser!.uid
        
        let level: Int? = 0
        let exp: Int? = 0
        let achievements: [String]? = [""]
        let numbevs: Int? = 0
        let money: Double? = 0.0

        db.collection("analytics").addDocument(data: ["uid": uid, "level": level, "exp": exp, "achievements": achievements, "numbevs": numbevs, "money": money])
        { (error) in
            if error != nil {
                print("there was an error!")
            } else {
                print("added new users!")
            }
            
        }
        
    }
    
    static func createNewUser(username: String, email: String, user_icon: String) {
        
        print("creating new users!")
        
        let db = Firestore.firestore()
        
        if username != "" && email != "" {
            
            let icon: String = user_icon
            let uid: String = Auth.auth().currentUser!.uid
            let title: String? = "coffee connoisseur"


            db.collection("user").addDocument(data: ["username": username, "email": email, "uid": uid, "icon": icon, "title": title])
            { (error) in
                if error != nil {
                    print("there was an error!")
                } else {
                    print("added new users!")
                }
            }
            
            createNewUserAnalytics()
        }
    }
}
