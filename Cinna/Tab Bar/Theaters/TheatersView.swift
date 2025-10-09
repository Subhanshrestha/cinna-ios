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
            VStack {
                switch viewModel.state {
                case .idle, .loading:
                    VStack(spacing: 12) {
                        ProgressView("Finding theaters near you…")
                            .progressViewStyle(CircularProgressViewStyle())
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
                                .padding(.top, 20)
                        }
                        .frame(maxHeight: .infinity)
                    } else {
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(theaters, id: \.id) { theater in
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(theater.name)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        if let rating = theater.rating {
                                            Text("⭐️ \(rating, specifier: "%.1f")")
                                                .foregroundColor(.orange)
                                        }
                                        if let addr = theater.address {
                                            Text(addr)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(radius: 1)
                                    .padding(.horizontal)
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
            .navigationTitle("Theaters")
            .task {
                await viewModel.loadNearbyTheaters()
            }
        }
    }
}
