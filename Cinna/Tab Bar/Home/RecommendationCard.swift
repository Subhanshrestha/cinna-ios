//
//  RecommendationCard.swift
//  Cinna
//
//  Created by Chao Chen on 10/9/25.
//

import SwiftUI

struct RecommendationCard: View {
    let recommendation: MovieRecommendation

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            LinearGradient(
                gradient: Gradient(colors: [Color(.systemOrange), Color(.systemPink)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(width: 72, height: 108)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                Image(systemName: "film.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.white)
            )

            VStack(alignment: .leading, spacing: 8) {
                Text(recommendation.title)
                    .font(.headline)
                    .foregroundStyle(Color(.label))

                Text(recommendation.description)
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                    .lineLimit(3)

                HStack(spacing: 12) {
                    Label(recommendation.details, systemImage: "clock")
                        .font(.caption)
                        .foregroundStyle(Color(.secondaryLabel))

                    RatingBadge(text: recommendation.rating)
                }

                HStack(spacing: 8) {
                    ForEach(recommendation.tags, id: \.self) { tag in
                        TagBadge(text: tag)
                    }
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color(.quaternarySystemFill), lineWidth: 1)
        )
    }
}
