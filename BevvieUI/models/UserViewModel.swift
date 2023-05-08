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

class UserViewModel: ObservableObject {
    
    @Published var user: UserModel = UserModel()
    private var db = Firestore.firestore()
    
    init () {
        
        db.collection("user").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid).addSnapshotListener { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                    print("No Documents")
                    return
                }
                
                let doc = documents[0]
                let data = doc.data()
            
                //print("getting data on \(data["username"])")

                let username = data["username"] as! String
                let email = data["email"]  as! String
                let uid = data["uid"]  as! String
                let level = data["level"] as! Int
                let exp = data["experience"] as! Int
                let achievements = data["achievements"] as! [String]
                let numbevs = data["numbevs"] as! Int
                let icon = data["icon"] as! String
                let money = data["money"] as! Double
                
            self.user = UserModel(username: username, email: email, uid: uid, level: level, exp: exp, achievements: achievements, numbevs: numbevs, icon: icon, money: money)


                }
        }
}
