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
    @Published var name: String {
        didSet { defaults.set(name, forKey: Keys.name) }
    }

    @Published var useCurrentLocationBool: Bool {
        didSet {
            defaults.set(useCurrentLocationBool, forKey: Keys.useCurrentLocationBool)

            if !useCurrentLocationBool && currentLocation != nil {
                currentLocation = nil
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

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        name = defaults.string(forKey: Keys.name) ?? ""

        if defaults.object(forKey: Keys.useCurrentLocationBool) != nil {
            useCurrentLocationBool = defaults.bool(forKey: Keys.useCurrentLocationBool)
        } else {
            useCurrentLocationBool = false
        }

        if let latitude = defaults.object(forKey: Keys.latitude) as? Double,
           let longitude = defaults.object(forKey: Keys.longitude) as? Double {
            currentLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            currentLocation = nil
        }
    }

    func updateLocation(_ coordinate: CLLocationCoordinate2D) {
        useCurrentLocationBool = true
        currentLocation = coordinate
    }

    func clearLocation() {
        useCurrentLocationBool = false
        currentLocation = nil
    }

    private enum Keys {
        static let name = "userInfo.name"
        static let useCurrentLocationBool = "userInfo.useCurrentLocation"
        static let latitude = "userInfo.latitude"
        static let longitude = "userInfo.longitude"
    }
}
