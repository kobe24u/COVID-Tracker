//
//  SegmentedPicker.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 8/9/21.
//

import SwiftUI

struct SegmentedPicker: View {
  @Binding var recordType: RecordType
  var body: some View {
    Picker("Current selected record type", selection: $recordType) {
      ForEach(RecordType.allCases, id: \.self) {
        Text($0.rawValue)
      }
    }
    .pickerStyle(SegmentedPickerStyle())
  }
}
