//
//  MovieDetailView.swift
//  Cinna
//
//  Created by Chao Chen on 10/9/25.
//

import SwiftUI

struct MovieDetailView: View {
    let recommendation: MovieRecommendation

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(recommendation.title)
                        .font(.largeTitle.bold())
                        .foregroundStyle(Color(.label))

                    Text(recommendation.details)
                        .font(.subheadline)
                        .foregroundStyle(Color(.secondaryLabel))

                    Text(recommendation.description)
                        .font(.body)
                        .foregroundStyle(Color(.secondaryLabel))
                }

                VStack(alignment: .leading, spacing: 16) {
                    DetailSection(title: "Condensed AI Review", content: recommendation.aiReview)
                    DetailSection(title: "AI Summary", content: recommendation.aiSummary)
                }
            }
            .padding(24)
        }
        .background(Color(.systemGroupedBackground))
    }
}
