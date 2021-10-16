//
//  LocationManager.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 9/10/21.
//

import MapKit

enum MapDetails {
  static let startingLocation = CLLocationCoordinate2D(
    latitude: -36.9848,
    longitude: 143.3906
  )
  static let defaultSpan = MKCoordinateSpan(
    latitudeDelta: 10,
    longitudeDelta: 10
  )
  static let liveSpan = MKCoordinateSpan(
    latitudeDelta: 0.1,
    longitudeDelta: 0.1
  )
}


final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  @Published var region = MKCoordinateRegion(
    center: MapDetails.startingLocation,
    span: MapDetails.defaultSpan
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
      guard let currentLocation = locationManager.location else { return }
      region = .init(
        center: currentLocation.coordinate,
        span: MapDetails.liveSpan
      )
    @unknown default:
      break
    }
  }
  
  func setRegion(with coordinate: CLLocationCoordinate2D) {
    self.region = .init(
      center: coordinate,
      span: MapDetails.liveSpan
    )
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    checkLocationAuthorization()
  }
}
