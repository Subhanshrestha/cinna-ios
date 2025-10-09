//
//  Login.swift
//  Cinna
//
//  Created by Brighton Young on 10/9/25.
//

import SwiftUI

struct LoginView: View {
    
    var onContinue: () -> Void
    @State private var currentLoginPage = 0
    
    //for user page
    @State private var userName: String = ""
    @State private var userSelectedGenres: Set<Genre> = []
    @State private var useCurrentLocation: Bool = false
    
    var body: some View {
        TabView(selection: $currentLoginPage) {
            WelcomeView(next: {
                withAnimation { currentLoginPage = 1 }
            })
            .tag(0)
            
            UserInfoView(
                name: $userName,
                selectedGenres: $userSelectedGenres,
                useCurrentLocation: $useCurrentLocation,
                next: {
                    withAnimation { currentLoginPage = 2 }
                })
            .tag(1)
            
            ReadyView(finish : {
                withAnimation {
                    onContinue()}
            },
                      name: userName
            )
            .tag(2)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    LoginView { }
}
