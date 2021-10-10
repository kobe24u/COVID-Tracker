//
//  TestingSitesMapView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 9/10/21.
//

import MapKit
import SwiftUI

struct MapView: View {
  @StateObject var locationManager: LocationManager = .init()
  @StateObject var mapViewProvider: MapViewProvider = .init(api: APIService())
  
  var body: some View {
    ZStack(alignment: .top) {
      Map(
        coordinateRegion: $locationManager.region,
        showsUserLocation: true
      )
      .ignoresSafeArea(.container, edges: .top)
      .accentColor(Color(.systemPink))
      .onAppear {
        locationManager.checkIfLocationServicesIsEnabled()
        Task {
          await mapViewProvider.asyncFetchMapData()
        }
      }
      
      MapTypePicker()
      .environmentObject(mapViewProvider)
      .pickerStyle(SegmentedPickerStyle())
      .padding(.top, 16)
      .padding(.horizontal, 64)
    }
  }
}
