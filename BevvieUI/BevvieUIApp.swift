//
//  BevvieUIApp.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/18/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
//import FirebaseCore
//
//
class AppDelegate: NSObject, UIApplicationDelegate {
    
    var userModel: UserViewModel?
    var anaModel: UserAnalyticsViewModel?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
            // Initialize Firebase
            FirebaseConfiguration.shared.setLoggerLevel(FirebaseLoggerLevel.min)
            FirebaseApp.configure()

            // other app initialization code
            userModel = UserViewModel()
            anaModel = UserAnalyticsViewModel()

            return true
        }

    
    
}

@main
struct BevvieUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var userModel = UserViewModel()
    @StateObject var anaModel = UserAnalyticsViewModel()


    var body: some Scene {
        WindowGroup {
            MasterView(username: .constant(""), email: .constant(""))
                .environmentObject(userModel)
                .environmentObject(anaModel)
        }
    }
}
