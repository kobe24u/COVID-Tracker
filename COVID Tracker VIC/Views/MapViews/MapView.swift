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
        showsUserLocation: true,
        annotationItems: mapViewProvider.testSites
      ) { site in
        MapAnnotation(coordinate: site.clLocation) {
          Image(systemName: "testtube.2")
          .foregroundColor(.red)
          .padding(5)
          .background(Color.white)
          .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
          .overlay(
              Image(systemName: "arrowtriangle.left.fill")
                  .rotationEffect(Angle(degrees: 270))
                  .foregroundColor(.white)
                  .offset(y: 10)
              ,
              alignment: .bottom
          )
          .onTapGesture {
            print(site.Site_Name)
          }
        }
      }
      .ignoresSafeArea(.container, edges: .top)
      .accentColor(Color(.systemPink))
      .onAppear {
        locationManager.checkIfLocationServicesIsEnabled()
        Task {
          await mapViewProvider.asyncFetchMapData()
        }
      }
      
      VStack {
        MapTypePicker()
        .environmentObject(mapViewProvider)
        .pickerStyle(SegmentedPickerStyle())
        .padding(.top, 16)
        .padding(.horizontal, 64)
        
        Spacer()
        
        HStack {
          Spacer()
          Button(action: {
            locationManager.checkIfLocationServicesIsEnabled()
          }, label: {
            Image("map-reset-icon")
              .resizable()
              .renderingMode(.template)
              .tint(.secondary)
              .scaledToFit()
          })
            .frame(width: 32, height: 32)
            .padding(.trailing, 16)
            .padding(.bottom, 32)
        }
      }
    }
  }
}
