//
//  LocationManager.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 9/10/21.
//

import MapKit
import Foundation

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  
  @Published var region = MKCoordinateRegion(
    center: .init(latitude: -37.8136, longitude: 144.9631),
    span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05)
  )
  
  var locationManager: CLLocationManager?
  
  func checkIfLocationServicesIsEnabled() {
    if CLLocationManager.locationServicesEnabled() {
      locationManager = CLLocationManager()
      locationManager?.delegate = self
    } else {
      fatalError("Location service has not been turned on")
    }
  }
  
  private func checkLocationAuthorization() {
    guard let locationManager = locationManager else { return }

    switch locationManager.authorizationStatus {
      
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .restricted:
      fatalError("Location service has been restricted")
    case .denied:
      fatalError("Location service has been denied. Please go to Settings to enable it.")
    case .authorizedAlways, .authorizedWhenInUse:
      guard let currentLocation = locationManager.location?.coordinate else { return }
      region = .init(
        center: currentLocation,
        span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05)
      )
    @unknown default:
      break
    }
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    checkLocationAuthorization()
  }
}
