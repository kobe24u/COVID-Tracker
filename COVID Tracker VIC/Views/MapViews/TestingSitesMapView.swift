//
//  TestingSitesMapView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 9/10/21.
//

import MapKit
import SwiftUI

struct TestingSitesMapView: View {
  @EnvironmentObject var locationManager: LocationManager
  
  var body: some View {
    Map(
      coordinateRegion: $locationManager.region,
      showsUserLocation: true
    )
    .ignoresSafeArea(.container, edges: .top)
    .accentColor(Color(.systemPink))
    .onAppear {
      locationManager.checkIfLocationServicesIsEnabled()
    }
  }
}
