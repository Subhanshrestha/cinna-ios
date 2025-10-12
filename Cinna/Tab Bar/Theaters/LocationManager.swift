
//
//  LocationManager.swift
//  Cinna
//
//  Created by Subhan Shrestha on 10/9/25.
//

import Foundation
import CoreLocation

enum LocationError: LocalizedError {
    case permissionDenied
    case locationUnavailable
    
    var errorDescription: String? {
        switch self {
        case .permissionDenied:
            return "Location permission was denied. Please enable it in Settings."
        case .locationUnavailable:
            return "Unable to determine your location."
        }
    }
}

final class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var continuation: CheckedContinuation<CLLocationCoordinate2D, Error>?
    private var authorizationContinuation: CheckedContinuation<CLAuthorizationStatus, Error>?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    // MARK: - Async request
    @MainActor
    func requestLocation() async throws -> CLLocationCoordinate2D {
        try await ensureAuthorization()
        
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            manager.requestLocation()
        }
    }
    
    @MainActor
    private func ensureAuthorization() async throws {
        switch manager.authorizationStatus {
        case .notDetermined:
            let status = try await requestAuthorization()
            guard status == .authorizedWhenInUse || status == .authorizedAlways else {
                throw LocationError.permissionDenied
            }
        case .authorizedWhenInUse, .authorizedAlways:
            return
        case .denied, .restricted:
            throw LocationError.permissionDenied
        @unknown default:
            throw LocationError.permissionDenied
        }
    }
    
    @MainActor
    private func requestAuthorization() async throws -> CLAuthorizationStatus {
        return try await withCheckedThrowingContinuation { continuation in
            authorizationContinuation = continuation
            manager.requestWhenInUseAuthorization()
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else {
            continuation?.resume(throwing: LocationError.locationUnavailable)
            continuation = nil
            return
        }
        
        continuation?.resume(returning: coordinate)
        continuation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleAuthorizationChange(status: manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleAuthorizationChange(status: status)
    }
    
    private func handleAuthorizationChange(status: CLAuthorizationStatus) {
        guard let authorizationContinuation else { return }
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            authorizationContinuation.resume(returning: status)
        case .denied, .restricted:
            authorizationContinuation.resume(throwing: LocationError.permissionDenied)
        case .notDetermined:
            return
        @unknown default:
            authorizationContinuation.resume(throwing: LocationError.permissionDenied)
        }
        
        self.authorizationContinuation = nil
    }
}
