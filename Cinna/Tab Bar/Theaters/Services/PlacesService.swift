//
//  PlacesService.swift
//  Cinna
//
//  Created by Subhan Shrestha on 10/9/25.
//

import Foundation
import CoreLocation

// MARK: - Protocol

/// Abstract definition for any location-based movie theater data provider.
protocol PlacesService {
    func nearbyMovieTheaters(at coordinate: CLLocationCoordinate2D,
                             radius: Int) async throws -> [Theater]
}

// MARK: - Google Places Implementation

/// Google Places API–based implementation of PlacesService.
struct GooglePlacesService: PlacesService {
    private let apiKey: String

    init() throws {
        guard
            let key = Bundle.main.object(forInfoDictionaryKey: "G_PLACES_API_KEY") as? String,
            !key.isEmpty
        else { throw APIError.missingKey }
        self.apiKey = key
    }

    func nearbyMovieTheaters(at coordinate: CLLocationCoordinate2D,
                             radius: Int = 15000) async throws -> [Theater] {
        
        print("📍 Searching near: \(coordinate.latitude), \(coordinate.longitude)")

        // Build the request URL
        var comps = URLComponents(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json")!
        comps.queryItems = [
            URLQueryItem(name: "keyword", value: "movie theater"),
            URLQueryItem(name: "type", value: "movie_theater"),
            URLQueryItem(name: "location", value: "\(coordinate.latitude),\(coordinate.longitude)"),
            URLQueryItem(name: "radius", value: "25000"),
            URLQueryItem(name: "key", value: apiKey)
        ]
        print("🔗 URL: \(comps.url!)") // 👈 add this one too


        guard let url = comps.url else { throw APIError.badURL }

        // Fetch and decode response
        let response: GooglePlacesResponse = try await APIClient.getJSON(url)

        // Map to Theater model
        return response.results.map {
            Theater(
                id: $0.place_id,
                name: $0.name,
                rating: $0.rating,
                address: $0.vicinity,
                location: .init(
                    latitude: $0.geometry.location.lat,
                    longitude: $0.geometry.location.lng
                )
            )
        }
    }
}

// MARK: - Response Decoding

/// Codable structs that represent the JSON structure returned by Google Places API.
private struct GooglePlacesResponse: Decodable {
    let results: [PlaceResult]

    struct PlaceResult: Decodable {
        let place_id: String
        let name: String
        let rating: Double?
        let vicinity: String?
        let geometry: Geometry

        struct Geometry: Decodable {
            let location: Location
            struct Location: Decodable {
                let lat: Double
                let lng: Double
            }
        }
    }
}
