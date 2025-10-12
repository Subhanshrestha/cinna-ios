//
//  UserInfoData.swift
//  Cinna
//
//  Created by Brighton Young on 10/10/25.
//

import Combine
import CoreLocation
import Foundation

final class UserInfoData: ObservableObject {
    
    // MARK: - Published user fields
    @Published var name: String {
        didSet { defaults.set(name, forKey: Keys.name) }
    }
    
    /// Mirror flag if you want to show a toggle/switch elsewhere (optional).
    @Published var useCurrentLocationBool: Bool {
        didSet {
            defaults.set(useCurrentLocationBool, forKey: Keys.useCurrentLocationBool)
            if !useCurrentLocationBool {
                resetStoredLocation()
            }
        }
    }
    
    @Published var currentLocation: CLLocationCoordinate2D? {
        didSet {
            if let currentLocation {
                defaults.set(currentLocation.latitude, forKey: Keys.latitude)
                defaults.set(currentLocation.longitude, forKey: Keys.longitude)
            } else {
                defaults.removeObject(forKey: Keys.latitude)
                defaults.removeObject(forKey: Keys.longitude)
            }
        }
    }
    
    @Published var locationPreference: LocationPreference? {
        didSet {
            if let locationPreference {
                defaults.set(locationPreference.rawValue, forKey: Keys.locationPreference)
            } else {
                defaults.removeObject(forKey: Keys.locationPreference)
            }
        }
    }
    
    // MARK: - Storage
    private let defaults: UserDefaults
    
    // MARK: - Init
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        
        // Load
        self.name = defaults.string(forKey: Keys.name) ?? ""
        self.useCurrentLocationBool = defaults.object(forKey: Keys.useCurrentLocationBool) as? Bool ?? false
        
        if let lat = defaults.object(forKey: Keys.latitude) as? CLLocationDegrees,
           let lon = defaults.object(forKey: Keys.longitude) as? CLLocationDegrees {
            self.currentLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        } else {
            self.currentLocation = nil
        }
        
        if let raw = defaults.string(forKey: Keys.locationPreference),
           let pref = LocationPreference(rawValue: raw) {
            self.locationPreference = pref
        } else {
            self.locationPreference = nil
        }
    }
    
    // MARK: - Public helpers used by the view
    func updateLocation(_ coordinate: CLLocationCoordinate2D, preference: LocationPreference) {
        currentLocation = coordinate
        locationPreference = preference
        useCurrentLocationBool = true
    }
    
    func clearLocation() {
        if useCurrentLocationBool {
            useCurrentLocationBool = false
        } else {
            resetStoredLocation()
        }
    }
    
    private func resetStoredLocation() {
        currentLocation = nil
        locationPreference = nil
    }
    
    // MARK: - Keys
    private enum Keys {
        static let name = "UserInfo.name"
        static let useCurrentLocationBool = "UserInfo.useCurrentLocationBool"
        static let latitude = "UserInfo.latitude"
        static let longitude = "UserInfo.longitude"
        static let locationPreference = "UserInfo.locationPreference"
    }
}
