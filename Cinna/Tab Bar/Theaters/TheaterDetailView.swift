//
//  TheaterDetailView.swift
//  Cinna
//
//  Created by Subhan Shrestha on 10/10/25.
//

import SwiftUI
import MapKit
import CoreLocation

struct TheaterDetailView: View {
    let theater: Theater

    // Map region centered on the theater
    @State private var region: MKCoordinateRegion

    init(theater: Theater) {
        self.theater = theater
        _region = State(initialValue: MKCoordinateRegion(
            center: theater.location,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        ))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Map with a single pin at the theater
                Map(coordinateRegion: $region, annotationItems: [theater]) { t in
                    MapMarker(coordinate: t.location, tint: .yellow)
                }
                .frame(height: 240)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                )

                // Title & rating
                VStack(alignment: .leading, spacing: 8) {
                    Text(theater.name)
                        .font(.title2).bold()
                        .foregroundColor(.primary)

                    HStack(spacing: 8) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(theater.rating.map { String(format: "%.1f", $0) } ?? "—")
                            .foregroundColor(.yellow)
                        Text("rating")
                            .foregroundColor(.secondary)
                    }
                    .font(.headline)
                }

                // Address
                if let addr = theater.address {
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.secondary)
                        Text(addr)
                            .foregroundColor(.secondary)
                    }
                }

                // Placeholder for future showtimes/seat map/etc.
                VStack(alignment: .leading, spacing: 6) {
                    Text("Coming Soon")
                        .font(.headline)
                    Text("Live showtimes, seat previews, and best-value tickets will appear here.")
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding()
        }
        .navigationTitle("Theater Info")
        .navigationBarTitleDisplayMode(.inline)
        .background(
            LinearGradient(
                colors: [Color.black, Color.gray.opacity(0.25)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}

#Preview {
    TheaterDetailView(theater: Theater(
        id: "demo",
        name: "AMC Metreon 16",
        rating: 4.4,
        address: "135 4th St, San Francisco, CA",
        location: CLLocationCoordinate2D(latitude: 37.78455, longitude: -122.40334)
    ))
}
