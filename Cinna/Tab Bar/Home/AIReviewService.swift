//
//  AIReviewService.swift
//  Cinna
//  Hard coded reviews for now
//  Created by Chao Chen on 10/9/25.
//

protocol AIReviewService {
    func summarize(_ movie: MovieRecommendation) async throws -> (review: String, summary: String)
}

struct MockAIReviewService: AIReviewService {
    func summarize(_ movie: MovieRecommendation) async throws -> (review: String, summary: String) {
        (movie.aiReview, movie.aiSummary)
    }
}
