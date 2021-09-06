//
//  EntryPointView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import SwiftUI

struct RecordsContentView: View {
  @StateObject var apiCaller: APICaller
  
  var body: some View {
    Group {
      if apiCaller.isLoading {
        LoadingView()
      } else if apiCaller.errorMessage != nil {
        ErrorView(apiCaller: apiCaller)
      } else {
        RecordsListView(apiCaller: apiCaller)
      }
    }
    .onAppear {
      apiCaller.fetchLGARecords()
    }
  }
}
