//
//  Home.swift
//  Cinna
//
//  Created by Brighton Young on 9/26/25.
//

import SwiftUI

struct Home: View {
    private let recommendations: [MovieRecommendation] = [
        .init(
            title: "The Little Mermaid",
            description: "The youngest of King Triton’s daughters, Ariel is a beautiful and spirited young mermaid with a thirst for adventure.",
            details: "2h 15m · 2023",
            rating: "G",
            tags: ["3D", "DUB", "SUB"],
            aiSummary: "A reimagined fairy tale following Ariel as she navigates love, family expectations, and her longing for life on land.",
            aiReview: "AI Aggregated Positive: Audiences praise Halle Bailey’s heartfelt performance and the film’s lush underwater world, though pacing drags in the second act."
        ),
        .init(
            title: "The Super Mario Bros Movie",
            description: "While working underground to fix a water main, Mario gets transported to the Mushroom Kingdom and joins Princess Peach.",
            details: "1h 32m · 2023",
            rating: "PG",
            tags: ["3D", "DUB", "SUB"],
            aiSummary: "Mario and Luigi get swept into a colorful quest to save the Mushroom Kingdom, blending slapstick humor with nods to longtime fans.",
            aiReview: "AI Aggregated Positive: Families love the brisk pacing and vibrant animation, though some critics wish for deeper character development."
        ),
        .init(
            title: "Guardians of the Galaxy Vol. 3",
            description: "Still reeling from the loss of Gamora, Peter Quill must rally his team for a mission to defend the universe.",
            details: "2h 29m · 2023",
            rating: "R",
            tags: ["3D", "DUB", "SUB"],
            aiSummary: "The Guardians embark on an emotional rescue mission that delves into Rocket’s origin while closing out the trilogy with heart.",
            aiReview: "AI Aggregated Positive: Critics applaud the emotional stakes and soundtrack, noting tonal shifts between humor and heavy themes."
        )
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Recommended for you")
                        .font(.largeTitle.bold())
                        .foregroundStyle(Color(.label))

                    VStack(spacing: 16) {
                        ForEach(recommendations) { recommendation in
                            NavigationLink(value: recommendation) {
                                RecommendationCard(recommendation: recommendation)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 32)
            }
            .background(Color(.systemGroupedBackground))
            .navigationDestination(for: MovieRecommendation.self) { recommendation in
                MovieDetailView(recommendation: recommendation)
            }
            .navigationTitle("Home")
        }
    }
}

// MARK: - RecommendationCard

private struct RecommendationCard: View {
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

// MARK: - Supporting Models & Views

private struct MovieRecommendation: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let details: String
    let rating: String
    let tags: [String]
    let aiSummary: String
    let aiReview: String
}

// MARK: - MovieDetailView

private struct MovieDetailView: View {
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

private struct DetailSection: View {
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color(.systemYellow).opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            Text(content)
                .font(.body)
                .foregroundStyle(Color(.label))
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
}

private struct RatingBadge: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(.systemYellow).opacity(0.2))
            .foregroundStyle(Color(.systemOrange))
            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
    }
}

private struct TagBadge: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(Color(.tertiarySystemFill))
            .foregroundStyle(Color(.secondaryLabel))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

#Preview {
    ContentView() // Preview with the real TabView host
}
