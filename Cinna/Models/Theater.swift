//
//  Theater.swift
//  Cinna
//
//  Created by Subhan Shrestha on 10/9/25.
//

import Foundation
import CoreLocation

/// Represents a single movie theater with its essential metadata.
struct Theater: Identifiable, Hashable {
    let id: String
    let name: String
    let rating: Double?
    let address: String?
    let location: CLLocationCoordinate2D

    // MARK: - Manual Equatable & Hashable conformance
    static func == (lhs: Theater, rhs: Theater) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

