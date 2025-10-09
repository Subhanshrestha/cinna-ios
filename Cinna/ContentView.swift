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
    
    @AppStorage("hasCompletedLogin") private var hasCompletedLogin: Bool = false
    @State private var selectedTab: Tab = .home

    var body: some View {
        // See Docs/SwiftUIGrouping.md for guidance on when lightweight wrappers
        // like `Group` are helpful. In this view each branch already returns a
        // single container (`TabView` or `LoginView`), so an extra Group would
        // only add noise without changing layout.
        if hasCompletedLogin {
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
        } else {
            LoginView {
                hasCompletedLogin = true
            }
        }
    }

}

#Preview {
    ContentView()
}
