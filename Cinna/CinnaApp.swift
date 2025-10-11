//
//  CinnaApp.swift
//  Cinna
//
//  Created by Subhan Shrestha on 9/25/25.
//

import SwiftUI

@main
struct CinnaApp: App {
    @StateObject private var userInfo = UserInfoData()
    @StateObject private var moviePreferences = MoviePreferencesData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userInfo)
                .environmentObject(moviePreferences)
        }
    }
}
