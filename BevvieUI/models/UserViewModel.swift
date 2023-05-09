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
        print("getting user info")
        db.collection("user").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid).addSnapshotListener { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                    print("No Documents")
                    return
                }
                
                let doc = documents[0]
                let data = doc.data()
            

                let username = data["username"] as! String
                let email = data["email"]  as! String
                let uid = data["uid"]  as! String
                let icon = data["icon"] as! String
                let title = data["title"] as! String

//                let level = data["level"] as! Int
//                let exp = data["experience"] as! Int
//                let achievements = data["achievements"] as! [String]
//                let numbevs = data["numbevs"] as! Int
//                let money = data["money"] as! Double
                
            self.user = UserModel(username: username, email: email, uid: uid, icon: icon, title: title)


                }
        }
}
