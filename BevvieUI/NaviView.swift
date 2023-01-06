//
//  NaviView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/20/22.
//

import Foundation
import SwiftUI

struct NaviView: View {
    
    var body: some View {
        TabView() {
            HomeView(isPresenting: .constant(false), isLoggedIn: .constant(true)) // <- Need a view
                .tabItem {
                    Image(systemName: "house")
                        .foregroundColor(.black)
                    Text("Home")
                }
            .tag("One")
            LogInView(isSignedUp: .constant(false), isLoggedIn: .constant(false)) // <- Need a view
                .tabItem {
                    Image(systemName: "bell")
                        .foregroundColor(.black)
                    Text("Home")
                }
            .tag("Two")
            LogInView(isSignedUp: .constant(false), isLoggedIn: .constant(false)) // <- Need a view
                .tabItem {
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                    Text("Home")
                }
            .tag("Three")
            LogInView(isSignedUp: .constant(false), isLoggedIn: .constant(false)) // <- Need a view
                .tabItem {
                    Image(systemName: "house")
                        .foregroundColor(.black)
                    Text("Home")
                }
            .tag("Four")
        }
    }
    
}

struct FirstView: View {
    var body: some View {
        Color(.red).opacity(0.1)
    }
}
