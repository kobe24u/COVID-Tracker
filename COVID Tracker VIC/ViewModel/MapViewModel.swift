//
//  MapViewModel.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 10/10/21.
//

import Combine
import Foundation
import SwiftUI
import MapKit

@MainActor
class MapViewModel: ObservableObject {
  @Published var mapType: MapType = .testSites
  @Published var isLoading: Bool = false
  @Published var errorMessage: String? = nil
  @Published var sites: [SiteType] = []
  @Published var site: SiteType? = nil
  @Published var searchText = ""
  @Published var places: [Place] = []
  private let api: APIService
  private var cancellables: Set<AnyCancellable> = []
  
  init(api: APIService) {
    self.api = api
  }
  
  func asyncFetchMapData(of type: MapType = .testSites) async {
    isLoading = true
    do {
      if type == .testSites {
        let response: TestSitesResponse = try await api.asyncFetch(type.apiEndpoint)
        sites = response.sites.map { SiteType(from: $0) }
      } else {
        let vaxCentres: [VaxCentre] = try await api.asyncFetch(type.apiEndpoint)
        sites = vaxCentres.map { SiteType(from: $0) }
      }
      isLoading = false
    } catch {
      self.errorMessage = error.localizedDescription
    }
  }
  
  func searchQuery() async throws{
    places.removeAll()
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = searchText
    
    do {
      let response = try await MKLocalSearch(request: request).start()
      self.places = response.mapItems.compactMap {
        Place(place: $0.placemark)
      }
    } catch {
      throw error
    }
  }
}
