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
  @StateObject var mapViewModel: MapViewModel = .init(api: APIService())
  @State var searchText = ""
  // Gesture properties
  @State var offSet: CGFloat = 0
  @State var lastOffSet: CGFloat = 0
  @GestureState var gestureOffSet: CGFloat = 0
  
  var body: some View {
    ZStack(alignment: .top) {
      Group {
        if mapViewModel.mapType == .testSites {
          Map(
            coordinateRegion: $locationManager.region,
            showsUserLocation: true,
            annotationItems: mapViewModel.testSites
          ) { site in
            MapAnnotation(coordinate: site.clLocation) {
              MapAnnotationView(mapType: .testSites)
              .onTapGesture {
                withAnimation {
                 offSet = -250
                }
              }
            }
          }
        } else {
          Map(
            coordinateRegion: $locationManager.region,
            showsUserLocation: true,
            annotationItems: mapViewModel.vaxCentres
          ) { centre in
            MapAnnotation(coordinate: centre.clLocation) {
              MapAnnotationView(mapType: .vaxCentres)
              .onTapGesture {
                withAnimation {
                 offSet = -250
                }
              }
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
            
            VStack(spacing: 16) {
   
              Capsule()
                .fill(.white)
                .frame(width: 60, height: 4)
                .padding(.top)
              
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
                
            }
            .padding(.horizontal)
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
