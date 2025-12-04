//
//  LocationService.swift
//  StormChaser
//
//  Created by Smeet Chavda on 2025-12-03.
//

import Foundation
import CoreLocation

final class LocationService: NSObject, ObservableObject {
    @Published var lastLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestAuthorizationIfNeeded() {
        let status = manager.authorizationStatus
        
        switch status {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
                
            case .authorizedWhenInUse, .authorizedAlways:
                // START updating location continuously
                manager.startUpdatingLocation()
                
            default:
                break
        }
    }
    
    func refreshLocation() {
        manager.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        
        switch authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                manager.startUpdatingLocation()       // IMPORTANT!
                
            default:
                break
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.last
        print("UPDATED LOCATION → \(String(describing: lastLocation))")
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("Location error:", error.localizedDescription)
    }
}
