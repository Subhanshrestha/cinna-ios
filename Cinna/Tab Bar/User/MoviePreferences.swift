//
//  MoviePreferences.swift
//  Cinna
//
//  Created by Brighton Young on 10/4/25.
//

import SwiftUI

struct MoviePreferences: View {
    var body: some View {
        ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Movie Preferences")
                            .font(.largeTitle.bold())

                        Text("Tune your favorite genres, moods, and theater settings from here.")
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .navigationTitle("Movie Preferences")
                .navigationBarTitleDisplayMode(.inline)
    }
}
