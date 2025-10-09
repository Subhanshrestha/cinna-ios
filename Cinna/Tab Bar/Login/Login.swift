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
                PlaceholderField(title: "Email")
                PlaceholderField(title: "Password", isSecure: true)
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

private struct PlaceholderField: View {

    let title: String
    var isSecure: Bool = false

    var body: some View {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
            .strokeBorder(.gray.opacity(0.3))
            .frame(height: 52)
            .overlay(alignment: .leading) {
                Text(title)
                    .foregroundStyle(.gray.opacity(0.7))
                    .padding(.horizontal)
            }
    }
}

#Preview {
    LoginView { }
}

