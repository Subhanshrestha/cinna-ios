//
//  MoviePreferencesData.swift
//  Cinna
//
//  Created by Brighton Young on 10/10/25.
//

import Combine
import Foundation

final class MoviePreferencesData: ObservableObject {
    @Published var selectedGenres: Set<Genre> {
        didSet {
            let rawValues = selectedGenres.map(\.rawValue).sorted()
            defaults.set(rawValues, forKey: Keys.genres)
        }
    }

    var sortedSelectedGenresArray: [Genre] {
        selectedGenres.sorted { $0.title < $1.title }
    }

    var sortedSelectedGenresString: String {
        sortedSelectedGenresArray.map(\.title).joined(separator: ", ")
    }

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        if let storedGenres = defaults.array(forKey: Keys.genres) as? [String] {
            let genres = storedGenres.compactMap(Genre.init(rawValue:))
            selectedGenres = Set(genres)
        } else {
            selectedGenres = []
        }
    }

    func toggleGenre(_ genre: Genre) {
        if selectedGenres.contains(genre) {
            selectedGenres.remove(genre)
        } else {
            selectedGenres.insert(genre)
        }
    }

    private enum Keys {
        static let genres = "moviePreferences.genres"
    }
}


