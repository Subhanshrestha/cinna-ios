
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

    @Published var state: State = .idle
    private let placesService: PlacesService
    private var lastLoadedCoordinate: CLLocationCoordinate2D?

    init(placesService: PlacesService? = nil) {
        do {
            self.placesService = try placesService ?? GooglePlacesService()
            print("✅ GooglePlacesService initialized successfully")
        } catch {
            fatalError("❌ Failed to initialize GooglePlacesService: \(error)")
        }
    }

    func loadNearbyTheaters(coordinate: CLLocationCoordinate2D) async {
        if let lastLoadedCoordinate,
           abs(lastLoadedCoordinate.latitude - coordinate.latitude) < 0.0001,
           abs(lastLoadedCoordinate.longitude - coordinate.longitude) < 0.0001,
           case .loaded = state {
            return
        }

        print("🚀 loadNearbyTheaters() called")
        state = .loading
        do {
            print("📍 Got coordinate: \(coordinate.latitude), \(coordinate.longitude)")
            let theaters = try await placesService.nearbyMovieTheaters(at: coordinate, radius: 15000)
            print("🎬 API returned \(theaters.count) theaters")
            lastLoadedCoordinate = coordinate
            state = .loaded(theaters)
        } catch {
            print("❌ Error in loadNearbyTheaters(): \(error.localizedDescription)")
            state = .error(error)
        }
    }

    func reset() {
        lastLoadedCoordinate = nil
        state = .idle
    }
}
