//
//  RecordsViewModel.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Combine
import SwiftUI

enum RecordsViewState: ViewState {
  case idle
  case loading
  case error(message: String)
  case results(records: [Record])
}

enum RecordsViewAction: Action {
  case fetchRecords(type: RecordType = .lga, url: URL? = RecordType.lga.apiEndpoint)
}


class RecordsViewModel: MVIViewModel {
  typealias S = RecordsViewState
  
  typealias A = RecordsViewAction
  @Published var viewState: RecordsViewState = .idle
  
  @Published var lgaRecordsSectionDictionary: Dictionary<String, [Record]> = [:]
  @Published var postcodeRecords: [Record] = []

  @Published var newCases: Int = 0
  @Published var activeCases: Int = 0
  @Published var recordType: RecordType = .lga
  @Published var nextPostcodeRequestURL: URL? = RecordType.postcode.apiEndpoint
  @Published var postcodeListFull = false
  
  private let api: APIServiceType
  private var cancellables: Set<AnyCancellable> = []
  
  init(api: APIServiceType = APIService()) {
    self.api = api
  }
  
  func reduce(currentState: RecordsViewState, action: RecordsViewAction) -> RecordsViewState {
    switch action {
    case .fetchRecords(_, _): return .loading
    }
  }
  
  func runSideEffect(action: RecordsViewAction, currentState: RecordsViewState) {
    switch action {
    case .fetchRecords(let type, let url):
      Task{
        await asyncFetchRecords(of: type, url: url)
      }
    }
  }
  
  /*
  // Combine Style Async call
  func fetchRecords(of type: RecordType = .lga, url: URL? = RecordType.lga.apiEndpoint) {
    let sub: AnyPublisher<Response, APIError> = api.fetch(url)
    sub
    .sink { [weak self] completion in
      switch completion {
      case .finished: break
      case .failure(let error):
        self?.viewState = .error(message: error.description)
      }
    } receiveValue: { [weak self] in
      self?.handleRecords(of: type, response: $0)
    }
    .store(in: &cancellables)
  }
   */
  
  func asyncFetchRecords(
    of type: RecordType = .lga,
    url: URL? = RecordType.lga.apiEndpoint
  ) async {
    do {
      let response: Response = try await api.asyncFetch(url)
      handleRecords(of: type, response: response)
    } catch {
      self.viewState = .error(message: error.localizedDescription)
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
    self.viewState = .results(records: records)
  }
}
