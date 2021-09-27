//
//  SegmentedPicker.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 8/9/21.
//

import SwiftUI

struct SegmentedPicker: View {
  @EnvironmentObject var recordsProvider: RecordsProvider
  var body: some View {
    Picker("Current selected record type", selection: $recordsProvider.recordType) {
      ForEach(RecordType.allCases, id: \.self) {
        Text($0.rawValue)
      }
    }.onChange(of: recordsProvider.recordType) { value in
      if value == .postcode && recordsProvider.postcodeRecords.isEmpty {
//        recordsProvider.fetchRecords(of: .postcode, url: recordsProvider.nextPostcodeRequestURL)
        Task {
          await recordsProvider.asyncFetchRecords(of: .postcode, url: recordsProvider.nextPostcodeRequestURL)
        }
      }
    }
    .pickerStyle(SegmentedPickerStyle())
    .padding([.leading, .trailing], 16)
  }
}
