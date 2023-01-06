//
//  UserViewModel.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/30/22.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class BevViewModel: ObservableObject {
    
    @Published var bev: BevModel = BevModel()
    @Published var bevCount: Int = 0
    
    private var db = Firestore.firestore()
    
    init () {
            db.collection("bevs").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                    print("No Documents")
                    return
                }
                
                self.bevCount = documents.count
                print(documents.count)
                
                let doc = documents[0]
                let data = doc.data()
                
//                let doc = documents[0]
//                let data = doc.data()
//
//                let uid = data["uid"] as! String
//                let name = data["name"]  as! String
//                let location = data["location"]  as! String
//                let temp = data["temp"] as! String
//                let price = data["price"] as! Float
//                let type = data["type"] as! String
//                let size = data["size"] as! String
//                //let date = data["date"] as! String
//                let satisfaction = data["satisfaction"] as! String
//
//
//                self.bev = BevModel(uid: uid, name: name, location: location, temp: temp, price: price, type: type, size: size, satisfaction: satisfaction)


                }
        }
}
