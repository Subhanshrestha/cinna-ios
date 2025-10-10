//
//  UserInfoData.swift
//  Cinna
//
//  Created by Brighton Young on 10/10/25.
//

import Combine
import Foundation

final class UserInfoData: ObservableObject {
    @Published var name: String {
        didSet { defaults.set(name, forKey: Keys.name) }
    }

    @Published var useCurrentLocation: Bool {
        didSet { defaults.set(useCurrentLocation, forKey: Keys.useCurrentLocation) }
    }

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        name = defaults.string(forKey: Keys.name) ?? ""

        if defaults.object(forKey: Keys.useCurrentLocation) != nil {
            useCurrentLocation = defaults.bool(forKey: Keys.useCurrentLocation)
        } else {
            useCurrentLocation = false
        }
    }

    private enum Keys {
        static let name = "userInfo.name"
        static let useCurrentLocation = "userInfo.useCurrentLocation"
    }
}
