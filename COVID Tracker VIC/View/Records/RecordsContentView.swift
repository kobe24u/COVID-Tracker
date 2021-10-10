//
//  EntryPointView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import SwiftUI

struct RecordsContentView: View {
  @EnvironmentObject var recordsViewModel: RecordsViewModel
  
  var body: some View {
    Group {
      if recordsViewModel.errorMessage != nil {
        ErrorView()
      } else {
        RecordsListView()
      }
    }
  }
}
