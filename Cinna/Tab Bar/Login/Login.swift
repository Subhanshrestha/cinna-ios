//
//  Login.swift
//  Cinna
//
//  Created by Brighton Young on 10/9/25.
//

import SwiftUI

struct LoginView: View {
    
    var onContinue: () -> Void
    @EnvironmentObject private var userInfo: UserInfoData
    @EnvironmentObject private var moviePreferences: MoviePreferencesData
    @State private var currentLoginPage = 0
    
    var body: some View {
        TabView(selection: $currentLoginPage) {
            WelcomeView(next: {
                withAnimation { currentLoginPage = 1 }
            })
            .tag(0)
            
            UserInfoView(next: {
                    withAnimation { currentLoginPage = 2 }
                })
            .tag(1)
            
            ReadyView(
                finish: {
                    withAnimation {
                        onContinue()
                    }
                },
                name: userInfo.name
            )
            .tag(2)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    LoginView { }
        .environmentObject(UserInfoData())
        .environmentObject(MoviePreferencesData())
}
