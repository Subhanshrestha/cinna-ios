//
//  HomeViewModel.swift
//  Cinna
//
//  Created by Chao Chen on 10/9/25.
//

import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var recommendations: [MovieRecommendation] = []
    @Published var isLoading = false
    @Published var error: String?

    private let movieService: MovieService
    private let aiService: AIReviewService

    init(movieService: MovieService = MockMovieService(), aiService: AIReviewService = MockAIReviewService()) {
        self.movieService = movieService
        self.aiService = aiService
    }

    func load() async {
        isLoading = true
        error = nil
        do {
            let items = try await movieService.fetchRecommendations()
            recommendations = try await withThrowingTaskGroup(of: MovieRecommendation.self) { group in
                for item in items {
                    group.addTask {
                        let pair = try await self.aiService.summarize(item)
                        return MovieRecommendation(
                            title: item.title,
                            description: item.description,
                            details: item.details,
                            rating: item.rating,
                            tags: item.tags,
                            aiSummary: pair.summary,
                            aiReview: pair.review
                        )
                    }
                }
                var output: [MovieRecommendation] = []
                for try await m in group { output.append(m) }
                return output
            }
        } catch {
            self.error = String(describing: error)
        }
        isLoading = false
    }
}
