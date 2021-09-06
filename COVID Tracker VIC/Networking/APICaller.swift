//
//  APICaller.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Combine
import Foundation

class APICaller: ObservableObject {
  @Published var records = [Record]()
  @Published var lgaRecordsSectionDictionary: Dictionary<String, [Record]> = [:]
  @Published var isLoading = false
  @Published var errorMessage: String? = nil
  private var cancellables: Set<AnyCancellable> = []
  
  func fetchLGARecords() {
    isLoading = true
    APIService().fetchRecords(of: .lga)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
      switch completion {
      case .finished: self?.isLoading = false
      case .failure(let error): self?.errorMessage = error.description
      }
    } receiveValue: { [weak self] in
      self?.records = $0
      self?.lgaRecordsSectionDictionary = self?.getSectionedLgaRecordsDictionary() ?? [:]
    }
    .store(in: &cancellables)
  }
  
  private func getSectionedLgaRecordsDictionary() -> Dictionary<String, [Record]> {
    return Dictionary(grouping: records, by: {
        let lgaString = $0.lgaString
        let normalizedlgaString = lgaString.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
        let firstChar = String(normalizedlgaString.first!).uppercased()
        return firstChar
    })
  }
}
