//
//  ReadyPage.swift
//  Cinna
//
//  Created by Brighton Young on 10/9/25.
//

import SwiftUI

struct ReadyView: View {
    var finish: () -> Void
    var name: String

    var body: some View {
        VStack(spacing: 24) {
            Spacer(minLength: 24)

            Image("UserPicture")
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 96)
                .symbolRenderingMode(.hierarchical)
                .foregroundColor(.accentColor)

            VStack(spacing: 8) {
                Text("All Set, \(name.isEmpty ? "my Cinna" : name)!")
                    .font(.largeTitle).bold()

                Text("\(Text("Cinna").italic()) is now able to work tirelessly for you around the clock for no pay!")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            Button {
                finish()
            } label: {
                Text("Go to Home")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.loginPrimary)

            Spacer()
        }
        .padding(.top, 48)
        .background(Color(.systemBackground))
    }
}
