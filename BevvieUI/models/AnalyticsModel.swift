//
//  UserAnalyticsViewModel.swift
//  BevvieUI
//
//  Created by Allison Ngo on 1/3/23.
//
//  analytics model that performs functions on firebase to gather data

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AnalyticsModel: ObservableObject {
    

    @Published var analytics: Analytics = Analytics()
    var temp: Analytics = Analytics(uid: "0", level: 0, exp: 0, achievements: [""], numbevs: 0, money: 0.0)
    private var db = Firestore.firestore()
    
    
    
    func getAnalytics () {
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
            
            self.analytics = Analytics(uid: uid, level: level, exp: exp, achievements: achievements, numbevs: numbevs, money: money)
    }
    
            
    
    }
    
}
