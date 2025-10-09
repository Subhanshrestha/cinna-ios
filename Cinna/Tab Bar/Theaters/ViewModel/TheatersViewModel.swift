
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
    private let locationManager = LocationManager()

    init(placesService: PlacesService? = nil) {
        do {
            self.placesService = try placesService ?? GooglePlacesService()
            print("✅ GooglePlacesService initialized successfully")
        } catch {
            fatalError("❌ Failed to initialize GooglePlacesService: \(error)")
        }
    }

    func loadNearbyTheaters() async {
        print("🚀 loadNearbyTheaters() called")
        state = .loading
        do {
            let coordinate = try await locationManager.requestLocation()
            print("📍 Got coordinate: \(coordinate.latitude), \(coordinate.longitude)")
            let theaters = try await placesService.nearbyMovieTheaters(at: coordinate, radius: 15000)
            print("🎬 API returned \(theaters.count) theaters")
            state = .loaded(theaters)
        } catch {
            print("❌ Error in loadNearbyTheaters(): \(error.localizedDescription)")
            state = .error(error)
        }
    }
}
