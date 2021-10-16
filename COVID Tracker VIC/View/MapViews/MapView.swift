//
//  TestingSitesMapView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 9/10/21.
//

import MapKit
import SwiftUI

struct MapView: View {
  @Environment(\.openURL) var openURL
  @StateObject var locationManager: LocationManager = .init()
  @StateObject var mapViewModel: MapViewModel = .init(api: APIService())
  @State var searchText = ""
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
      
      GeometryReader { proxy -> AnyView in
        
        let height = proxy.frame(in: .global).height
        
        return AnyView(
          ZStack {
            BlurView(style: .systemThinMaterialDark)
              .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
            
            VStack(alignment: .leading, spacing: 16) {
   
              HStack {
                Spacer()
                Capsule()
                  .fill(.white)
                  .frame(width: 60, height: 4)
                  .padding(.top)
                Spacer()
              }
              
              MapTypePicker()
                .onChange(of: mapViewModel.mapType, perform: { newValue in
                  locationManager.checkIfLocationServicesIsEnabled()
                  withAnimation {
                    offSet = 0
                  }
                })
                .environmentObject(mapViewModel)
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
              
              TextField("Search...", text: $searchText)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(BlurView(style: .dark))
                .cornerRadius(10)
                .colorScheme(.dark)
              
              if let site = mapViewModel.site{
                Text(site.name)
                  .font(.headline)
                
                Text(site.fullAddress)
                  .font(.subheadline)
              
                if let phoneNumberString = site.phone {                 
                  Button(action: {
                      let telephone = "tel://"
                      let formattedString = telephone + phoneNumberString
                      guard let url = URL(string: formattedString) else { return }
                      UIApplication.shared.open(url)
                     }) {
                     Text(phoneNumberString)
                  }
                }
                
                if let websiteString = site.website,
                   let webSiteURL = URL(string: websiteString) {
                  Button("Book Online") {
                      openURL(webSiteURL)
                  }
                }
                
                Text(site.availability)
                  .font(.footnote)
              }
            }
            .padding(.horizontal, 8)
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
  
  func onChange() {
    DispatchQueue.main.async {
      self.offSet = gestureOffSet + lastOffSet
    }
  }
}
