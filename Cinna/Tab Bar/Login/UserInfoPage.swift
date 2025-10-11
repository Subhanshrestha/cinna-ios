//
//  UserInfoPage.swift
//  Cinna
//
//  Created by Brighton Young on 10/9/25.
//

import SwiftUI

private enum LocationRequestState: Equatable {
    case idle
    case requesting
    case success
    case failure(String)
}

struct UserInfoView: View {

    @EnvironmentObject private var userInfo: UserInfoData
    @EnvironmentObject private var moviePreferences: MoviePreferencesData

    var next: () -> Void

    @State private var locationRequestState: LocationRequestState = .idle
    @StateObject private var locationManager = LocationManager()

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
                    VStack(alignment: .leading, spacing: 12) {
                        if userInfo.hasSavedLocation {
                            Label("Location saved", systemImage: "checkmark.circle.fill")
                                .font(.headline)
                                .foregroundStyle(.green)
                            Text(userInfo.formattedLocationDescription)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        } else {
                            Text("Use your current location so we can find theaters nearby.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }

                        Button {
                            requestLocation()
                        } label: {
                            HStack {
                                if locationRequestState == .requesting {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                        .tint(.white)
                                }
                                Text(userInfo.hasSavedLocation ? "Update Current Location" : "Use Current Location")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(locationRequestState == .requesting)

                        if case let .failure(message) = locationRequestState {
                            Text(message)
                                .font(.footnote)
                                .foregroundColor(.red)
                        } else if locationRequestState == .success {
                            Text("Location updated.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
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

#Preview {
    UserInfoView(next: { })
        .environmentObject(UserInfoData())
        .environmentObject(MoviePreferencesData())
}

private extension UserInfoView {
    func requestLocation() {
        locationRequestState = .requesting

        Task {
            do {
                let coordinate = try await locationManager.requestLocation()
                await MainActor.run {
                    userInfo.locationCoordinate = coordinate
                    locationRequestState = .success
                }
            } catch {
                await MainActor.run {
                    locationRequestState = .failure(error.localizedDescription)
                }
            }
        }
    }
}
