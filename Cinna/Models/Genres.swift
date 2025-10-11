//
//  Genres.swift
//  Cinna
//
//  Created by Brighton Young on 10/10/25.
//

import Foundation

enum Genre: String, CaseIterable, Identifiable {
    case action
    case comedy
    case drama
    case thriller
    case horror
    case scifi
    case fantasy
    case romance
    case animation
    case documentary

    var id: String { rawValue }

    var title: String { rawValue.capitalized }

    var symbol: String {
        switch self {
        case .action: return "bolt.fill"
        case .comedy: return "face.smiling"
        case .drama: return "theatermasks.fill"
        case .thriller: return "eye"
        case .horror: return "exclamationmark.triangle"
        case .scifi: return "sparkles"
        case .fantasy: return "wand.and.stars"
        case .romance: return "heart.fill"
        case .animation: return "film.stack"
        case .documentary: return "doc.text.fill"
        }
    }
}


