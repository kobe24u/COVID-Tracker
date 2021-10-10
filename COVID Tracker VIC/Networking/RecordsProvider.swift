//
//  recordsProvider.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Combine
import Foundation
import SwiftUI

@MainActor
class RecordsProvider: ObservableObject {
  @Published var lgaRecordsSectionDictionary: Dictionary<String, [Record]> = [:]
  @Published var postcodeRecords: [Record] = []
  @Published var isLoading: Bool = false
  @Published var errorMessage: String? = nil
  @Published var newCases: Int = 0
  @Published var activeCases: Int = 0
  @Published var recordType: RecordType = .lga
  @Published var nextPostcodeRequestURL: URL? = RecordType.postcode.apiEndpoint
  @Published var postcodeListFull = false
  
  private let api: APIService
  private var cancellables: Set<AnyCancellable> = []
  
  init(api: APIService) {
    self.api = api
  }
  
  func fetchRecords(of type: RecordType = .lga, url: URL? = RecordType.lga.apiEndpoint) {
    isLoading = true
    let sub: AnyPublisher<Response, APIError> = api.fetch(url)
    sub
    .sink { [weak self] completion in
      self?.isLoading = false
      switch completion {
      case .finished: break
      case .failure(let error): self?.errorMessage = error.description
      }
    } receiveValue: { [weak self] in
      self?.handleRecords(of: type, response: $0)
    }
    .store(in: &cancellables)
  }
  
  func asyncFetchRecords(of type: RecordType = .lga) async {
    let url: URL? = type.apiEndpoint
    isLoading = true
    do {
      let response: Response = try await api.asyncFetch(url)
      self.isLoading = false
      handleRecords(of: type, response: response)
    } catch {
      self.errorMessage = error.localizedDescription
    }
  }
  
  private func handleRecords(of type: RecordType, response: Response) {
    if type == .lga {
      self.lgaRecordsSectionDictionary = self.getSectionedRecordsDictionary(records: response.result.records)
      self.calculateNumbers(of: response.result.records)
    } else {
      self.nextPostcodeRequestURL = URL(string: baseURLString + response.result._links.next)
      self.postcodeRecords.append(contentsOf: response.result.records)
      self.postcodeRecords.sort { $0.postCodeString < $1.postCodeString }
      let currentPostcodeRecordsCount = self.postcodeRecords.count
      guard currentPostcodeRecordsCount >= response.result.total else { return }
      self.postcodeListFull = true
    }
  }
  
  private func getSectionedRecordsDictionary(records: [Record]) -> Dictionary<String, [Record]> {
    return Dictionary(grouping: records, by: {
      let searchString = $0.lgaString
      let normalizedlgaString = searchString.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
      let firstChar = String(normalizedlgaString.first!).uppercased()
      return firstChar
    })
  }
  
  private func calculateNumbers(of records: [Record]) {
    newCases = records.map { $0.newCasesInt }.reduce(0, +)
    activeCases = records.map { $0.activeCasesInt }.reduce(0, +)
  }
}
