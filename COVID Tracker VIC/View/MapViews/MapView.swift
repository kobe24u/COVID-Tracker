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
  @StateObject var mapViewModel: MapViewModel = .init()
  // Gesture properties
  @State var offSet: CGFloat = 0
  @State var lastOffSet: CGFloat = 0
  @GestureState var gestureOffSet: CGFloat = 0
  
  var body: some View {
    ZStack(alignment: .top) {
      Map(
        coordinateRegion: $locationManager.region,
        showsUserLocation: true,
        annotationItems: mapViewModel.sites
      ) { site in
        MapAnnotation(coordinate: site.clLocation) {
          MapAnnotationView(mapType: mapViewModel.mapType)
          .onTapGesture {
            withAnimation {
              mapViewModel.site = site
              offSet = -250
            }
          }
        }
      }
      .ignoresSafeArea(.container, edges: .top)
      .accentColor(Color(.systemPink))
      .onAppear {
        locationManager.checkIfLocationServicesIsEnabled()
        Task {
          await mapViewModel.asyncFetchMapData()
        }
      }
      
      VStack {
        ZStack {
          VStack(spacing: 0) {
            TextField("🔍 Search...", text: $mapViewModel.searchText)
              .padding(.vertical, 12)
              .padding(.horizontal, 16)
              .background(BlurView())
              .cornerRadius(18)
              
            if !mapViewModel.places.isEmpty && mapViewModel.searchText != "" {
              ScrollView {
                VStack(spacing: 8) {
                  ForEach(mapViewModel.places) {
                    if let name = $0.place.name,
                       let suburb = $0.place.locality,
                       let postcode = $0.place.postalCode,
                       let coordinate = $0.place.location?.coordinate {
                      Text(name + ", " + suburb + ", " + postcode)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .onTapGesture {
                          self.mapViewModel.searchText = ""
                          self.locationManager.setRegion(with: coordinate)
                        }
                      Divider()
                    }
                  }
                }
                .padding(.top)
              }
              .background(Color.white)
            }
          }
          .padding(.horizontal, 16)
          
          HStack {
            Spacer()
            Image(systemName: "location.circle.fill")
              .resizable()
              .frame(width: 32, height: 32)
              .padding(.trailing, 24)
              .onTapGesture {
                resetMap()
              }
          }
        }
        
        Spacer()
        
        GeometryReader { proxy -> AnyView in
          
          let height = proxy.frame(in: .global).height
          
          return AnyView(
            ZStack {
              BlurView()
                .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
              
              VStack(alignment: .leading, spacing: 16) {
                CentredCapsule()
                
                MapTypePicker()
                  .onChange(of: mapViewModel.mapType, perform: { newValue in
                    resetMap()
                  })
                  .environmentObject(mapViewModel)
                  .pickerStyle(SegmentedPickerStyle())
                  .padding(.horizontal)
                
                if let site = mapViewModel.site {
                  MapDrawerSiteDetailsView(site: site)
                }
              }
              .padding(.horizontal, 16)
              .frame(maxHeight: .infinity, alignment: .top)
            }
            .offset(y: height - 100)
            .offset(y: -offSet > 0 ? -offSet <= (height - 100) ? offSet : -(height - 100) : 0)
            .gesture(
              DragGesture()
                .updating($gestureOffSet, body: { value, out, _ in
                  out = value.translation.height
                  onChange()
                })
                .onEnded{ value in
                  let maxHeight = height - 100
                  withAnimation {
                    if -offSet > 100 && -offSet < maxHeight / 2{
                      offSet = -(maxHeight / 3)
                    } else if -offSet > maxHeight / 2 {
                      offSet = -maxHeight
                    } else {
                      mapViewModel.site = nil
                      offSet = 0
                    }
                  }
                }
            )
          )
        }
      }
    }
    .onChange(of: mapViewModel.searchText) { newValue in
      mapViewModel.site = nil
      withAnimation {
        offSet = 0
      }
      let delay = 0.1
      
      DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        if newValue == mapViewModel.searchText {
          Task {
           try await mapViewModel.searchQuery()
          }
        }
      }
    }
  }
  
  private func resetMap() {
    locationManager.checkIfLocationServicesIsEnabled()
    mapViewModel.site = nil
    withAnimation {
      offSet = 0
    }
  }
  
  private func onChange() {
    DispatchQueue.main.async {
      self.offSet = gestureOffSet + lastOffSet
    }
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView().preferredColorScheme(.dark)
    MapView().preferredColorScheme(.light)
  }
}
