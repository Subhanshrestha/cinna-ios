//
//  LocationPreference.swift
//  Cinna
//
//  Created by Brighton Young on 10/11/25.
//

import Foundation

enum LocationPreference: String, CaseIterable, Identifiable {
    case allowOnce
    case allowWhileUsing

    var id: String { rawValue }

    var successMessage: String {
        switch self {
        case .allowOnce:
            return "Current location saved."
        case .allowWhileUsing:
            return "Location saved while you use Cinna."
        }
    }

    var description: String {
        switch self {
        case .allowOnce:
            return "Share your current location a single time to find nearby theaters."
        case .allowWhileUsing:
            return "Keep your location available while you use Cinna."
        }
    }
}
