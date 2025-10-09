//
//  MovieModels.swift
//  Cinna
//
//  Created by Chao Chen on 10/9/25.
//

struct MovieRecommendation: Identifiable, Hashable {
    var id: String { title + details }
    let title: String
    let description: String
    let details: String
    let rating: String
    let tags: [String]
    let aiSummary: String
    let aiReview: String
}
