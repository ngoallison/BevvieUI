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
    
    var userModel: UserModel?
    var anaModel: AnalyticsModel?
    var bevModel: BevModel?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
            // Initialize Firebase
            FirebaseConfiguration.shared.setLoggerLevel(FirebaseLoggerLevel.min)
            FirebaseApp.configure()

            // other app initialization code
            userModel = UserModel()
            anaModel = AnalyticsModel()
            bevModel = BevModel()

            return true
        }

    
    
}

@main
struct BevvieUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var userModel = UserModel()
    @StateObject var anaModel = AnalyticsModel()
    @StateObject var bevModel = BevModel()



    var body: some Scene {
        WindowGroup {
            MasterView(username: .constant(""), email: .constant(""))
                .environmentObject(userModel)
                .environmentObject(anaModel)
                .environmentObject(bevModel)
        }
    }
}
