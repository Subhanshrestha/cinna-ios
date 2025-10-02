//
//  ContentView.swift
//  Cinna
//
//

import SwiftUI

struct ContentView: View {
    
    @State private var firstTab = "home" //startup on the home tab
    
    var body: some View {
        TabView(selection: $firstTab) {
            Theaters()
                .tabItem{
                    Label("Theaters", systemImage: "ticket")
                }
            Home()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag("home")
            User()
                .tabItem{
                    Label("User", systemImage: "person")
                }
            
        }
    }
    
}

#Preview {
    ContentView()
}
