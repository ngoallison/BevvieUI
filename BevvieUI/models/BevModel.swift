//
//  BevViewModel.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/30/22.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

/*
 var uid: String? = ""
 var name: String? = ""
 var location: String? = ""
 var temp: String? = ""
 var price: Float? = 0
 var type: String? = ""
 var size: String? = ""
 var date: Date? = Date()
 var satisfaction: String? = "happy-face"
 */

class BevModel: ObservableObject {
    
    @Published var bev: Bev = Bev()
    var temp: Bev = Bev(uid: "0", name: "Wintermelon Milk Tea", location: "OMOMO", temp: "ICED", price: 5.00, type: "Boba", size: "Large", date: Date(), satisfaction: "happy-face")
    @Published var bevCount: Int = 0
    
    private var db = Firestore.firestore()
    private var data: [QueryDocumentSnapshot] = []
    
    init () {
            db.collection("bevs").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid).addSnapshotListener { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                    print("No Documents")
                    return
                }
                
                self.bevCount = documents.count                
                self.data = documents

                }
        }
    
    func getFavorite() -> String {
        
        var dictionary: [String:Int] = [:]
        for doc in self.data {
            if let count = dictionary[doc["name"] as! String] {
                dictionary[doc["name"] as! String] = count + 1
                } else {
                    dictionary[doc["name"] as! String] = 1
                }
        }
        
        var maxFrequency = 0
        var favorite = ""
        for (name, frequency) in dictionary {
            if frequency > maxFrequency {
                maxFrequency = frequency
                favorite = name
            }
        }
        return favorite
    }
    
    func getType() -> String {
        
        var dictionary: [String:Int] = [:]
        for doc in self.data {
            if let count = dictionary[doc["type"] as! String] {
                dictionary[doc["type"] as! String] = count + 1
                } else {
                    dictionary[doc["type"] as! String] = 1
                }
        }
        
        var maxFrequency = 0
        var type = ""
        for (name, frequency) in dictionary {
            if frequency > maxFrequency {
                maxFrequency = frequency
                type = name
            }
        }
        return type
    }
    
    func getLocation() -> String {
        
        var dictionary: [String:Int] = [:]
        for doc in self.data {
            if let count = dictionary[doc["location"] as! String] {
                dictionary[doc["location"] as! String] = count + 1
                } else {
                    dictionary[doc["location"] as! String] = 1
                }
        }
        
        var maxFrequency = 0
        var location = ""
        for (name, frequency) in dictionary {
            if frequency > maxFrequency {
                maxFrequency = frequency
                location = name
            }
        }
        return location
    }
    
    func getDates() -> [Date] {
        
        var dates: [Date] = []
        for doc in self.data {
            let string = doc["date"] as! String
            // Create Date Formatter
            let dateFormatter = DateFormatter()

            // Set Date Format
            dateFormatter.dateFormat = "MM/dd/yyyy"

            // Convert String to Date
            let date = dateFormatter.date(from: string)!
            dates.append(date)
        }
        return dates;
    }
}
