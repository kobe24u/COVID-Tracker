//
//  recordsProvider.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Combine
import Foundation

class RecordsProvider: ObservableObject {
  @Published var lgaRecordsSectionDictionary: Dictionary<String, [Record]> = [:]
  @Published var postCodeRecordsSectionDictionary: Dictionary<String, [Record]> = [:]
  @Published var isLoading: Bool = false
  @Published var errorMessage: String? = nil
  @Published var newCases: Int = 0
  @Published var activeCases: Int = 0
  private let api: APIService
  private var records: [Record] = .init()
  private var cancellables: Set<AnyCancellable> = []
  
  init(api: APIService) {
    self.api = api
  }
  
  func fetchRecords(of type: RecordType) {
    isLoading = true
    let sub: AnyPublisher<Response, APIError> = api.fetch(type.apiEndpoint)
    sub
    .sink { [weak self] completion in
      self?.isLoading = false
      switch completion {
      case .finished: break
      case .failure(let error): self?.errorMessage = error.description
      }
    } receiveValue: { [weak self] in
      self?.records = $0.result.records
      if type == .lga {
        self?.lgaRecordsSectionDictionary = self?.getSectionedRecordsDictionary(type: type) ?? [:]
        self?.calculateTotalCaseNumbers()
      } else {
        self?.postCodeRecordsSectionDictionary = self?.getSectionedRecordsDictionary(type: type) ?? [:]
      }
    }
    .store(in: &cancellables)
  }
  
  private func getSectionedRecordsDictionary(type: RecordType) -> Dictionary<String, [Record]> {
    return Dictionary(grouping: records, by: {
      let searchString = type == .lga ? $0.lgaString : $0.postCodeString
      let normalizedlgaString = searchString.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
      let firstChar = String(normalizedlgaString.first!).uppercased()
      return firstChar
    })
  }
  
  private func calculateTotalCaseNumbers() {
    newCases = records.map { $0.newCasesInt }.reduce(0, +)
    activeCases = records.map { $0.activeCasesInt }.reduce(0, +)
  }
}
