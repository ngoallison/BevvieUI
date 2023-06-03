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

class UserModel: ObservableObject {
    
    @Published var user: User = User()
    private var db = Firestore.firestore()
    
    
    // function to access firebase to collect information about user, populate user object
    func getUser () {
        db.collection("user").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid as Any).addSnapshotListener { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("No Documents")
                return
            }
            
            if (documents.count == 0) {
                return
            }
            
            let doc = documents[0]
            let data = doc.data()
            
            
            let username = data["username"] as! String
            let email = data["email"]  as! String
            let uid = data["uid"]  as! String
            let icon = data["icon"] as! String
            let title = data["title"] as! String
            self.user = User(username: username, email: email, uid: uid, icon: icon, title: title)
            
            
        }
    }
}
