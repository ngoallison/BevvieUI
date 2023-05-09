//
//  UserAnalyticsModel.swift
//  BevvieUI
//
//  Created by Allison Ngo on 1/3/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct UserAnalyticsModel {
        
   // var happy: Float = 0
   // var sad: Float = 0
    var uid: String? = "0"
    var level: Int? = 0
    var exp: Int? = 0
    var achievements: [String]? = [""]
    var numbevs: Int? = 0
    var money: Double? = 0.0
   // var visited_location: String = ""
    
}


