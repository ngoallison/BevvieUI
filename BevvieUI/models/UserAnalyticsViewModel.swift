//
//  UserAnalyticsViewModel.swift
//  BevvieUI
//
//  Created by Allison Ngo on 1/3/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class UserAnalyticsViewModel: ObservableObject {
    
    @Published var analytics: UserAnalytics = UserAnalytics()

    private var db = Firestore.firestore()
    
    var satis: [String] = []
    var prices: [Float] = []
    
    init () {
        
        db.collection("bevs").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { (snapshot, error) in
        guard let documents = snapshot?.documents else {
                print("No Documents")
                return
            }
            
            for document in documents {
                let data = document.data()
                let price = data["price"] as! NSNumber
                
                self.prices.append(price.floatValue)
            }
            self.getSpent()
        }
    }
    
    func getSpent() {
        var total = (self.prices).reduce(0, +)
        print(total)
        self.analytics = UserAnalytics(spent: Double(total))
        
    }
    
    func getSatisfaction() {
        
        // get all bevs belonging to current user
        
        var satisfied = 0
        var unsatisfied = 0
        
        db.collection("bevs").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { (snapshot, error) in
        guard let documents = snapshot?.documents else {
                print("No Documents")
                return
            }
            
            for document in documents {
                let data = document.data()
                if data["satisfaction"] as! String == "happy-face" || data["satisfaction"] as! String == "cheery-face" {
                    satisfied += 1
                }
                else {
                    unsatisfied += 1
                }
            }
            
            print("satisfied:  \(satisfied/(satisfied + unsatisfied))")
        }
            
    
    }
    
}
