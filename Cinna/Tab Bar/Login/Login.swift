//
//  Login.swift
//  Cinna
//
//  Created by Brighton Young on 10/9/25.
//

import SwiftUI

struct LoginView: View {

    var onContinue: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            
            VStack(spacing: 8) {
                Text("Welcome to Cinna")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Sign in to start curating your personalized movie experience.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            VStack(spacing: 16) {
                TextField(title: "Name")
                TextField(title: "Password")
            }
            .padding(.horizontal)

            Button(action: onContinue) {
                Text("Continue")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.top, 72)
        .padding(.bottom)
        .background(Color(.systemBackground))
    }
}

#Preview {
    LoginView { }
}
