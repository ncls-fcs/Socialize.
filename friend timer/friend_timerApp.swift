//
//  friend_timerApp.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 09.10.22.
//
#warning("TODO: Add NotificationHandler Caller for overdue meetings")

import SwiftUI

@main
struct friend_timerApp: App {
    @StateObject private var modelData = ModelData()
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
