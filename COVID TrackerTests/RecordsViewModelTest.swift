//
//  RecordsViewModelTest.swift
//  COVID TrackerTests
//
//  Created by Vinnie Liu on 3/2/2022.
//

import Combine
import Foundation
import XCTest
@testable import COVID_Tracker_VIC

class RecordsViewModelTest: XCTestCase {
    var mockAPIService: APIServiceType!
    var recordsViewModel: RecordsViewModel!
    var cancellables: Set<AnyCancellable> = []
   
    @MainActor
    override func setUp() {
        mockAPIService = MockAPIService(mockAPIUrl: Bundle.main.url(forResource: "lga", withExtension: ".json"))
        recordsViewModel = .init(api: mockAPIService)
    }
    
    @MainActor
    func testLoadingSampleRecords(){
        let expectation = XCTestExpectation(description: "API call")
      Task {
        await recordsViewModel.asyncFetchRecords()
      }
//        recordsViewModel.fetchRecords()
        recordsViewModel.$newCases
        .dropFirst()
        .sink { _ in expectation.fulfill()}
        .store(in: &cancellables)
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(recordsViewModel.newCases, 5588)
    }
    
    override func tearDown() {

    }


}
