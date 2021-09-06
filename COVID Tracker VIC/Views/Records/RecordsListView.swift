//
//  ContentView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import SwiftUI

struct RecordsListView: View {
  @State var searchItem = ""
  @StateObject var apiCaller: APICaller
  private var navBarTitle: String {
    guard let latestAnnouncementDate = apiCaller.records.first?.announcedDate else { return "" }
    return latestAnnouncementDate.toHumanFriendlyString() + " 🦠 Update"
  }
  
  var body: some View {
    NavigationView {
      VStack {
        SearchBar(searchTerm: $searchItem)
        ListView(searchItem: $searchItem,
                 dictionary: apiCaller.lgaRecordsSectionDictionary)
      }
      .navigationBarTitle(navBarTitle)
    }
  }
}

private struct ListView: View {
  @Binding var searchItem: String
  let dictionary: Dictionary<String, [Record]>
  var body: some View {
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
        .font(.system(size: 20, weight: .semibold))
      Spacer()
      Text("\(record.newCasesInt) New Cases")
        .font(.system(size: 15, weight: .bold))
        .foregroundColor(record.riskLevel.promptColor)
    }
  }
}

