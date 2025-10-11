//
//  Profile.swift
//  Cinna
//
//  Created by Brighton Young on 10/4/25.
//

import SwiftUI
import CoreLocation

struct Profile: View {
    @EnvironmentObject private var userInfo: UserInfoData
    private let locationManager = LocationManager()
    
    @State private var isRequestingLocation = false
    @State private var locationStatusMessage: String?
    @State private var locationErrorMessage: String?
    
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
                
                
                Toggle("Use Current Location", isOn: $userInfo.useCurrentLocationBool)
                    .bold()
                    .tint(.accentColor)
                    .disabled(isRequestingLocation)
                    .onChange(of: userInfo.useCurrentLocationBool) { _, newValue in
                        if newValue {
                            Task { await requestCurrentLocation() }
                        } else if !isRequestingLocation {
                            locationStatusMessage = "Current location disabled."
                            locationErrorMessage = nil
                        }
                    }
                
                if isRequestingLocation {
                    HStack(spacing: 8) {
                        ProgressView()
                        Text("Updating location…")
                    }
                    .foregroundStyle(.secondary)
                } else if let locationStatusMessage {
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

extension Profile {
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
