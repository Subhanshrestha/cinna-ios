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

    @Published var useCurrentLocationBool: Bool {
        didSet { defaults.set(useCurrentLocationBool, forKey: Keys.useCurrentLocationBool) }
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
    }

    private enum Keys {
        static let name = "userInfo.name"
        static let useCurrentLocationBool = "userInfo.useCurrentLocation"
    }
}
