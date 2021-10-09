//
//  LGAListView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 8/9/21.
//

import SwiftUI

struct LGAListView: View {
  @Binding var searchItem: String
  @EnvironmentObject var recordsProvider: RecordsProvider
  var body: some View {
    List {
      ForEach(recordsProvider.lgaRecordsSectionDictionary.keys.sorted(), id:\.self) { key in
        if let filteredRecords = filterRecords(by: key), !filteredRecords.isEmpty {
              Section(header: Text("\(key)")) {
                ForEach(filteredRecords) { ListRow(record: $0, titleString: $0.lgaString) }
              }
          }
      }
    }
    .refreshable {
      Task {
        await recordsProvider.asyncFetchRecords()
      }
    }
    .listStyle(GroupedListStyle())
  }
  
  private func filterRecords(by key: String) -> [Record]? {
    return recordsProvider.lgaRecordsSectionDictionary[key]?.filter {
      self.searchItem.isEmpty ? true :
        $0.lgaString.lowercased()
        .starts(with: self.searchItem.lowercased())}
  }
}
