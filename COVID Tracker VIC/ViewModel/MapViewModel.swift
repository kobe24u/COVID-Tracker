//
//  MapViewModel.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 10/10/21.
//

import Combine
import Foundation
import SwiftUI

@MainActor
class MapViewModel: ObservableObject {
  @Published var mapType: MapType = .testSites
  @Published var isLoading: Bool = false
  @Published var errorMessage: String? = nil
  @Published var sites: [SiteType] = []
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
}
