//
//  WelcomePage.swift
//  Cinna
//
//  Created by Brighton Young on 10/9/25.
//
import SwiftUI

struct WelcomeView: View {
    var next: () -> Void

        var body: some View {
            VStack(spacing: 24) {
                Image("CinnaIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 240, height: 240)
                    .foregroundColor(.accentColor)
                
                Text("Welcome to \(Text("Cinna").italic())")
                    .font(.largeTitle).bold()
                
                Text("Your AI-powered movie companion, ready to tailor reviews, recommend films, and even show your seat view.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)

                Button("Get Started") {
                    next()
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
            }
            .padding()
        }
}

#Preview {
    WelcomeView{}
}
