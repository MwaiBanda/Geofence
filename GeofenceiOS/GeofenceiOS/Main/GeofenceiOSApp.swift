//
//  GeofenceiOSApp.swift
//  GeofenceiOS
//
//  Created by Mwai Banda on 5/23/22.
//

import SwiftUI
import Firebase
import FirebaseAnalytics

@main
struct GeofenceiOSApp: App {
    init() {
        FirebaseApp.configure()
        Analytics.setAnalyticsCollectionEnabled(true)

    }
    var body: some Scene {
        WindowGroup {
            ContentView()
            
        }
    }
}
