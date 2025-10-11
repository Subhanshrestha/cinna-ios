//
//  UserInfoPage.swift
//  Cinna
//
//  Created by Brighton Young on 10/9/25.
//

import SwiftUI
import CoreLocation

struct UserInfoView: View {

    @EnvironmentObject private var userInfo: UserInfoData
    @EnvironmentObject private var moviePreferences: MoviePreferencesData

    private let locationManager = LocationManager()

    @State private var isRequestingLocation = false
    @State private var locationStatusMessage: String?
    @State private var locationErrorMessage: String?

    var next: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Text("*Cinna*")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 24)

            List {
                Section("Your Name") {
                    SwiftUI.TextField("e.g., Success Qu'avon", text: $userInfo.name)
                        .textContentType(.name)
                        .contentShape(Rectangle())
                }

                Section("Location Preference") {
                    VStack(alignment: .leading, spacing: 8) {
                        Button {
                            Task { await requestCurrentLocation() }
                        } label: {
                            HStack {
                                if isRequestingLocation {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                }

                                Text(userInfo.useCurrentLocationBool ? "Location Saved" : "Use Current Location")
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.accentColor)
                        .disabled(isRequestingLocation)

                        if let locationStatusMessage {
                            Text(locationStatusMessage)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        } else if let locationErrorMessage {
                            Text(locationErrorMessage)
                                .font(.footnote)
                                .foregroundStyle(.red)
                        } else if userInfo.useCurrentLocationBool,
                                  userInfo.currentLocation != nil {
                            Text("Location saved and ready to use for nearby theaters.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        } else {
                            Text("Tap the button to allow Cinna to use your current location for nearby theaters.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Section("What do you like to watch?") {
                    ForEach(Genre.allCases) { genre in
                        Button {
                            moviePreferences.toggleGenre(genre)
                        } label: {
                            HStack {
                                Image(systemName: genre.symbol)
                                    .frame(width: 24)
                                Text(genre.title)
                                Spacer()
                                if moviePreferences.selectedGenres.contains(genre) {
                                    Image(systemName: "checkmark")
                                        .font(.body.weight(.semibold))
                                }
                            }
                            .contentShape(Rectangle()) //CRITICAL for making the button be tappable edge to edge
                        }
                        .buttonStyle(.plain)
                        
                    }
                }
                
            }
            .listStyle(.insetGrouped)
            
            Button {
                next()
            } label: {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                
            }
            .buttonStyle(.loginPrimary)
            .padding(.vertical, 12)
        }
        .background(Color(.systemBackground))
    }
}

#if DEBUG
#Preview {
    UserInfoView(next: { })
        .environmentObject(UserInfoData())
        .environmentObject(MoviePreferencesData())
}
#endif

extension UserInfoView {
    @MainActor
    private func requestCurrentLocation() async {
        guard !isRequestingLocation else { return }

        isRequestingLocation = true
        locationStatusMessage = nil
        locationErrorMessage = nil

        do {
            let coordinate = try await locationManager.requestLocation()
            userInfo.updateLocation(coordinate)
            locationStatusMessage = "Location saved successfully."
        } catch {
            userInfo.clearLocation()
            locationErrorMessage = error.localizedDescription
        }

        isRequestingLocation = false
    }
}
