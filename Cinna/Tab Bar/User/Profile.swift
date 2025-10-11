//
//  Profile.swift
//  Cinna
//
//  Created by Brighton Young on 10/4/25.
//

import SwiftUI

private enum ProfileLocationState: Equatable {
    case idle
    case requesting
    case success
    case failure(String)
}

struct Profile: View {
    @EnvironmentObject private var userInfo: UserInfoData

    @State private var locationState: ProfileLocationState = .idle
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        Form {
            Section("*Cinna* Profile Details") {
                    HStack{
                        Text("Name")
                            .bold()
                        SwiftUI.TextField("Your name", text: $userInfo.name)
                            .textContentType(.name)
                            .contentShape(Rectangle())
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        if userInfo.hasSavedLocation {
                            Label("Location saved", systemImage: "mappin.and.ellipse")
                                .font(.subheadline.weight(.semibold))
                            Text(userInfo.formattedLocationDescription)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        } else {
                            Text("Add your current location to personalize theater recommendations.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }

                        Button {
                            updateLocation()
                        } label: {
                            HStack {
                                if locationState == .requesting {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                }
                                Text(userInfo.hasSavedLocation ? "Update Location" : "Use Current Location")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .disabled(locationState == .requesting)

                        switch locationState {
                        case .failure(let message):
                            Text(message)
                                .font(.footnote)
                                .foregroundColor(.red)
                        case .success:
                            Text("Location updated.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        default:
                            EmptyView()
                        }
                    }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }//end body
}

#Preview {
    Profile()
        .environmentObject(UserInfoData())
}

private extension Profile {
    func updateLocation() {
        locationState = .requesting

        Task {
            do {
                let coordinate = try await locationManager.requestLocation()
                await MainActor.run {
                    userInfo.locationCoordinate = coordinate
                    locationState = .success
                }
            } catch {
                await MainActor.run {
                    locationState = .failure(error.localizedDescription)
                }
            }
        }
    }
}
