//
//  UserModel.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/15/22.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct UserModel {

    var username: String? = "boobs"
    var email: String? = "boobs@gmail.com"
    var uid: String? = "0"
    var level: Int? = 0
    var exp: Int? = 0
    var achievements: [String]? = []
    var numbevs: Int? = 0
    var icon: String? = "girl-icon"
    
}
