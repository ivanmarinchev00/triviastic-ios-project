//
//  TriviasticApp.swift
//  Triviastic
//
//  Created by Moni Manolov on 07/03/2021.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Your code here")
        FirebaseApp.configure()
        return true
    }
}

@main
struct TriviasticApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            //ContentView()
            LoginPage()
        }
    }
}
