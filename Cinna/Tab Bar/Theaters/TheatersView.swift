//
//  TheatersView.swift
//  Cinna
//
//  Created by Subhan Shrestha on 10/9/25.
//

import SwiftUI
import CoreLocation

struct TheatersView: View {
    @StateObject private var viewModel = TheatersViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                // Background for dark mode
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.3)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack {
                    switch viewModel.state {
                    case .idle, .loading:
                        VStack(spacing: 12) {
                            ProgressView("Finding theaters near you…")
                                .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                                .padding()
                            Text("Please ensure location access is allowed.")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .frame(maxHeight: .infinity)

                    case .loaded(let theaters):
                        if theaters.isEmpty {
                            VStack {
                                Text("No theaters found nearby 😔")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.top, 20)
                            }
                            .frame(maxHeight: .infinity)
                        } else {
                            ScrollView {
                                VStack(spacing: 14) {
                                    ForEach(theaters, id: \.id) { theater in
                                        NavigationLink(destination: TheaterDetailView(theater: theater)) {
                                            TheaterCardView(theater: theater)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                                .padding(.vertical)
                            }
                        }

                    case .error(let error):
                        VStack(spacing: 12) {
                            Text("⚠️ Error: \(error.localizedDescription)")
                                .foregroundColor(.red)
                            Button("Retry") {
                                Task {
                                    await viewModel.loadNearbyTheaters()
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .frame(maxHeight: .infinity)
                    }
                }
            }
            .navigationTitle("🎬 Theaters")
            .navigationBarTitleDisplayMode(.large)
            .task {
                await viewModel.loadNearbyTheaters()
            }
        }
    }
}

// MARK: - Theater Card Component
struct TheaterCardView: View {
    let theater: Theater

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            // ⭐️ Rating Section
            VStack(alignment: .center, spacing: 6) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.system(size: 22))
                Text(String(format: "%.1f", theater.rating ?? 0.0))
                    .foregroundColor(.yellow)
                    .font(.headline)
            }

            // 🎭 Theater Info
            VStack(alignment: .leading, spacing: 6) {
                Text(theater.name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(2)

                Text(theater.address ?? "Address not available")
                    .font(.subheadline)
                    .foregroundColor(Color.gray.opacity(0.8))
                    .lineLimit(1)
            }

            Spacer()
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.gray.opacity(0.25), Color.black.opacity(0.7)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.4), radius: 6, x: 0, y: 3)
        .padding(.horizontal)
    }
}
