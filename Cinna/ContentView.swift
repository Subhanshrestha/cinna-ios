//
//  ContentView.swift
//  Cinna
//
//

import SwiftUI

struct ContentView: View {
    
    private enum Tab: Hashable {
        case theaters
        case home
        case user
    }
    
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Theaters()
                .tabItem{
                    Label("Theaters", systemImage: "ticket")
                }
                .tag(Tab.theaters)
            
            Home()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)

            User()
                .tabItem{
                    Label("User", systemImage: "person")
                }
                .tag(Tab.user)
            
        }
    }
    
}

#Preview {
    ContentView()
}
