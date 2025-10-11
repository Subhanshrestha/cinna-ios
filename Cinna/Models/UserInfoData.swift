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

    @Published var locationCoordinate: CLLocationCoordinate2D? {
        didSet {
            if let coordinate = locationCoordinate {
                defaults.set(coordinate.latitude, forKey: Keys.locationLatitude)
                defaults.set(coordinate.longitude, forKey: Keys.locationLongitude)
            } else {
                defaults.removeObject(forKey: Keys.locationLatitude)
                defaults.removeObject(forKey: Keys.locationLongitude)
            }
        }
    }

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        name = defaults.string(forKey: Keys.name) ?? ""

        if defaults.object(forKey: Keys.locationLatitude) != nil,
           defaults.object(forKey: Keys.locationLongitude) != nil {
            let latitude = defaults.double(forKey: Keys.locationLatitude)
            let longitude = defaults.double(forKey: Keys.locationLongitude)
            locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            locationCoordinate = nil
        }
    }

    var hasSavedLocation: Bool {
        locationCoordinate != nil
    }

    var formattedLocationDescription: String {
        guard let coordinate = locationCoordinate else { return "Location not set" }
        return String(format: "Lat %.4f, Lon %.4f", coordinate.latitude, coordinate.longitude)
    }

    private enum Keys {
        static let name = "userInfo.name"
        static let locationLatitude = "userInfo.location.latitude"
        static let locationLongitude = "userInfo.location.longitude"
    }
}
