//
//  ContentView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import SwiftUI

struct RecordsListView: View {
  @State var searchItem = ""
  @EnvironmentObject var recordsViewModel: RecordsViewModel
  
  var body: some View {
    NavigationView {
      VStack(spacing: 16) {
        RecordsPicker()
        if recordsViewModel.recordType == .lga {
          LGAListView(searchItem: $searchItem)
        } else {
          PostcodeListView(searchItem: $searchItem)
        }
      }
      .searchable(text: $searchItem)
      .navigationBarTitle("🦠 Case Details ")
    }
    .environmentObject(recordsViewModel)
  }
}


