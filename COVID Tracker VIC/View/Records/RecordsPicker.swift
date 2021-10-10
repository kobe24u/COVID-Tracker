//
//  SegmentedPicker.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 8/9/21.
//

import SwiftUI

struct RecordsPicker: View {
  @EnvironmentObject var recordsViewModel: RecordsViewModel
  var body: some View {
    Picker("Current selected record type", selection: $recordsViewModel.recordType) {
      ForEach(RecordType.allCases, id: \.self) {
        Text($0.rawValue)
      }
    }.onChange(of: recordsViewModel.recordType) { value in
      if value == .postcode && recordsViewModel.postcodeRecords.isEmpty {
//        recordsViewModel.fetchRecords(of: .postcode, url: recordsViewModel.nextPostcodeRequestURL)
        Task {
          await recordsViewModel.asyncFetchRecords(of: .postcode)
        }
      }
    }
    .pickerStyle(SegmentedPickerStyle())
    .padding(.horizontal, 16)
  }
}
