//
//  APICaller.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Combine
import Foundation

class APICaller: ObservableObject {
  @Published var lGARecords = [LGARecord]()
  @Published var isLoading = false
  @Published var errorMessage: String? = nil
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    fetchLGARecords()
  }
  
  func fetchLGARecords() {
//    APIService().fetchRecords(of: .LGA)
//      .receive(on: DispatchQueue.main)
//      .sink { [weak self] completion in
//      switch completion {
//      case .finished: break
//      case .failure(let error): self?.errorMessage = error.description
//      }
//    } receiveValue: { [weak self] in self?.lGARecords = $0 }
//    .store(in: &cancellables)
  }
}
