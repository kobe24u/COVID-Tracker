//
//  TestSitesProvider.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 10/10/21.
//

import Combine
import Foundation
import SwiftUI

@MainActor
class MapViewProvider: ObservableObject {
  @Published var mapType: MapType = .testSites
  @Published var isLoading: Bool = false
  @Published var errorMessage: String? = nil
  @Published var testSites: [Site] = []
  private let api: APIService
  private var cancellables: Set<AnyCancellable> = []
  
  init(api: APIService) {
    self.api = api
  }
  
  func asyncFetchMapData(of type: MapType = .testSites) async {
    isLoading = true
    do {
      let response: TestSitesResponse = try await api.asyncFetch(type.apiEndpoint)
      isLoading = false
      testSites = response.sites
    } catch {
      self.errorMessage = error.localizedDescription
    }
  }
}
