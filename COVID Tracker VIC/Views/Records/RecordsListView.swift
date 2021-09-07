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
  private var navBarTitle: String {
    // The date API returned has not been updated, still showing yesterday, data is new, but date is not :(
//    guard let latestAnnouncementDate = recordsProvider.latestDataDate else { return "" }
//    return latestAnnouncementDate.toHumanFriendlyString() + " 🦠 Update"
    "🦠 Case Details "
  }
  
  var body: some View {
    NavigationView {
      VStack {
        //TODO This can be replaced with searchable modifier when Swift 5.5 is out
        SearchBar(searchTerm: $searchItem)
        ListView(searchItem: $searchItem,
                 dictionary: recordsProvider.lgaRecordsSectionDictionary)
      }
      .navigationBarTitle(navBarTitle)
    }
  }
}

private struct ListView: View {
  @Binding var searchItem: String
  let dictionary: Dictionary<String, [Record]>
  var body: some View {
    //TODO Add the Refreshable modifier when Swift 5.5 is out
    List {
      ForEach(dictionary.keys.sorted(), id:\.self) { key in
        if let filteredRecords = filterRecords(by: key), !filteredRecords.isEmpty {
              Section(header: Text("\(key)")) {
                ForEach(filteredRecords) { ListRow(record: $0) }
              }
          }
      }
    }.listStyle(GroupedListStyle())
  }
  
  private func filterRecords(by key: String) -> [Record]? {
    return dictionary[key]?.filter {
      self.searchItem.isEmpty ? true :
        $0.lgaString.lowercased()
        .starts(with: self.searchItem.lowercased())}
  }
}

private struct ListRow: View {
  let record: Record
  var body: some View {
    HStack() {
      Text(record.lgaString)
        .font(.system(size: 18, weight: .semibold))
      Spacer()
      Text("\(record.newCasesInt) New Cases")
        .font(.system(size: 15, weight: .bold))
        .foregroundColor(record.riskLevel.promptColor)
    }
  }
}

