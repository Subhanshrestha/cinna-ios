//
//  MovieService.swift
//  Cinna
//
//  Created by Chao Chen on 10/9/25.
//

protocol MovieService {
    func fetchRecommendations() async throws -> [MovieRecommendation]
}

struct MockMovieService: MovieService {
    func fetchRecommendations() async throws -> [MovieRecommendation] {
        [
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
                rating: "PG-13",
                tags: ["3D", "DUB", "SUB"],
                aiSummary: "The Guardians embark on an emotional rescue mission that delves into Rocket’s origin while closing out the trilogy with heart.",
                aiReview: "AI Aggregated Positive: Critics applaud the emotional stakes and soundtrack, noting tonal shifts between humor and heavy themes."
            )
        ]
    }
}
