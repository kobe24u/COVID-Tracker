//
//  PostcodeListView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 8/9/21.
//

import SwiftUI

struct PostcodeListView: View {
  @Binding var searchItem: String
  @EnvironmentObject var recordsProvider: RecordsProvider
  var filteredPostcodeList: [Record] {
    recordsProvider.postCodeRecords.filter {
            searchItem.isEmpty ? true : $0.postCodeString.starts(with: searchItem)
    }
  }
  var body: some View {
    //TODO Add the Refreshable modifier when Swift 5.5 is out
    List(filteredPostcodeList) {
      ListRow(record: $0, titleString: $0.postCodeString)
    }.listStyle(PlainListStyle())
  }
}
