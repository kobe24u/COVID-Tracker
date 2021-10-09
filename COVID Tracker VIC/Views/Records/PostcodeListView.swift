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
    recordsProvider.postcodeRecords.filter {
            searchItem.isEmpty ? true : $0.postCodeString.starts(with: searchItem)
    }
  }
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(filteredPostcodeList.indices, id: \.self) { index in
          let record = filteredPostcodeList[index]
          ListRow(record: record, titleString: record.postCodeString)
//          .onAppear {
//              if index == filteredPostcodeList.count - 5 &&
//                    filteredPostcodeList.count == recordsProvider.postcodeRecords.count && recordsProvider.postcodeListFull == false {
//                recordsProvider.fetchRecords(of: .postcode, url: recordsProvider.nextPostcodeRequestURL)
//              }
//          }
          .task {
            if index == filteredPostcodeList.count - 5 &&
                filteredPostcodeList.count == recordsProvider.postcodeRecords.count &&
                recordsProvider.postcodeListFull == false {
              await recordsProvider.asyncFetchRecords(of: .postcode, url: recordsProvider.nextPostcodeRequestURL)
            }
          }
          .padding([.leading, .trailing], 16)
          Divider()
        }
      }
    }
  }
}
