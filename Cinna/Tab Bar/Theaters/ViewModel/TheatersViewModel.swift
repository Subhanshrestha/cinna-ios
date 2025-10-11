
//
//  TheatersViewModel.swift
//  Cinna
//
//  Created by Subhan Shrestha on 10/9/25.
//

//
//  TheatersViewModel.swift
//  Cinna
//
//  Created by Subhan Shrestha on 10/9/25.
//

import Foundation
import CoreLocation

@MainActor
final class TheatersViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded([Theater])
        case error(Error)
    }

    enum TheatersLocationError: LocalizedError {
        case locationUnavailable

        var errorDescription: String? {
            switch self {
            case .locationUnavailable:
                return "Location unavailable. Enable \"Use Current Location\" during login to view nearby theaters."
            }
        }
    }

    @Published var state: State = .idle
    private let placesService: PlacesService

    init(placesService: PlacesService? = nil) {
        do {
            self.placesService = try placesService ?? GooglePlacesService()
            print("✅ GooglePlacesService initialized successfully")
        } catch {
            fatalError("❌ Failed to initialize GooglePlacesService: \(error)")
        }
    }

    func loadNearbyTheaters(at coordinate: CLLocationCoordinate2D?) async {
        print("🚀 loadNearbyTheaters() called")
        state = .loading

        guard let coordinate else {
            print("❌ Missing coordinate for theaters lookup")
            state = .error(TheatersLocationError.locationUnavailable)
            return
        }

        do {
            print("📍 Using coordinate: \(coordinate.latitude), \(coordinate.longitude)")
            let theaters = try await placesService.nearbyMovieTheaters(at: coordinate, radius: 15000)
            print("🎬 API returned \(theaters.count) theaters")
            state = .loaded(theaters)
        } catch {
            print("❌ Error in loadNearbyTheaters(): \(error.localizedDescription)")
            state = .error(error)
        }
    }

    func reset() {
        state = .idle
    }
}
