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
        ZStack{ //extra ZStack so it doesnt try to keep reanimating the actual ZStack
            ZStack {
                switch currentLoginPage {
                case 0:
                    WelcomeView(next: advanceToUserInfo)
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading)
                            )
                        )
                    
                case 1:
                    UserInfoView(next: advanceToReady)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        ))
                    
                default:
                    ReadyView(
                        finish: completeLogin,
                        name: userInfo.name
                    )
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        )
                    )
                }
            }
            .animation(.easeInOut, value: currentLoginPage)
        }
    }
}

private extension LoginView {
    func advanceToUserInfo() {
        withAnimation { currentLoginPage = 1 }
    }
    
    func advanceToReady() {
        withAnimation { currentLoginPage = 2 }
    }
    
    func completeLogin() {
        withAnimation {
            onContinue()
        }
    }
}

#Preview {
    LoginView { }
        .environmentObject(UserInfoData())
        .environmentObject(MoviePreferencesData())
}
