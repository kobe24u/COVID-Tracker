//
//  ContentView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import SwiftUI

struct RecordsListView: View {
  @State var searchItem = ""
  @EnvironmentObject var recordsProvider: RecordsProvider
  
  var body: some View {
    NavigationView {
      VStack(spacing: 16) {
        //TODO This can be replaced with searchable modifier when Swift 5.5 is out
        SearchBar(searchTerm: $searchItem)
        SegmentedPicker()
        if recordsProvider.recordType == .lga {
          LGAListView(searchItem: $searchItem)
        } else {
          PostcodeListView(searchItem: $searchItem)
        }
      }
      .navigationBarTitle("🦠 Case Details ")
    }
    .environmentObject(recordsProvider)
  }
}


