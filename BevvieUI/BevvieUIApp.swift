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
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseConfiguration.shared.setLoggerLevel(FirebaseLoggerLevel.min)
      FirebaseApp.configure()
      let db = Firestore.firestore()
      print(db)
    //let db = Firestore.firestore()


    return true
  }
}

@main
struct BevvieUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MasterView(username: .constant(""), email: .constant(""))
        }
    }
}
