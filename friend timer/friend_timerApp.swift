//
//  friend_timerApp.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 09.10.22.
//
#warning("TODO: Add Nofication System for overdue Meetings")

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
