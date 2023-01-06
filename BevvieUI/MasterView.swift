//
//  MasterView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/20/22.
//

import Foundation
import SwiftUI
import FirebaseFirestore

struct MasterView: View {
    
    @State var isSignedUp: Bool = false
    @State var isLoggedIn: Bool = false
    @State var loggedOut: Bool = false
    
    @Binding var username: String
    @Binding var email: String
    
    
    var body: some View {
        if !isSignedUp {
            SignUpView(isSignedUp: $isSignedUp, isLoggedIn: $isLoggedIn, choosingIcon: false)
        }
        else if !isLoggedIn {
            LogInView(isSignedUp: $isSignedUp, isLoggedIn: $isLoggedIn)
        }
        
        else {
            MainView()
        }
    }
}

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        MasterView(username: .constant(""), email: .constant(""))
    }
}
