//
//  UserAnalyticsViewModel.swift
//  BevvieUI
//
//  Created by Allison Ngo on 1/3/23.
//
/*
     var uid: String? = "0"
     var spent: Double = 0.00
     var level: Int? = 0
     var exp: Int? = 0
     var achievements: [String]? = []
     var numbevs: Int? = 0
     var money: Double? = 0
*/

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class UserAnalyticsViewModel: ObservableObject {
    

    @Published var analytics: UserAnalyticsModel = UserAnalyticsModel()
    var temp: UserAnalyticsModel = UserAnalyticsModel(uid: "0", level: 0, exp: 0, achievements: [""], numbevs: 0, money: 0.0)
    private var db = Firestore.firestore()
    
    
    
    init () {
        print("getting analytics")
        db.collection("analytics").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid as Any).addSnapshotListener { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("No Documents")
                return
            }
            
            print("creating analytics model")
            if (documents.count == 0) {
                return
            }
            
            let doc = documents[0]
            let data = doc.data()
            
            let uid = data["uid"] as! String
            let level = data["level"] as! Int
            let exp = data["exp"] as! Int
            let achievements = data["achievements"] as! [String]
            let numbevs = data["numbevs"] as! Int
            let money = data["money"] as! Double
            
            self.analytics = UserAnalyticsModel(uid: uid, level: level, exp: exp, achievements: achievements, numbevs: numbevs, money: money)
    }
    
            
    
    }
    
}
