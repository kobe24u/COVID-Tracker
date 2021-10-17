//
//  PostcodeListView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 8/9/21.
//

import SwiftUI

struct PostcodeListView: View {
  @Binding var searchItem: String
  @EnvironmentObject var recordsViewModel: RecordsViewModel
  var filteredPostcodeList: [Record] {
    recordsViewModel.postcodeRecords.filter {
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
//                    filteredPostcodeList.count == recordsViewModel.postcodeRecords.count && recordsViewModel.postcodeListFull == false {
//                recordsViewModel.fetchRecords(of: .postcode, url: recordsViewModel.nextPostcodeRequestURL)
//              }
//          }
          .task {
            if index == filteredPostcodeList.count - 5 &&
                filteredPostcodeList.count == recordsViewModel.postcodeRecords.count &&
                recordsViewModel.postcodeListFull == false {
              await recordsViewModel.asyncFetchRecords(of: .postcode, url: recordsViewModel.nextPostcodeRequestURL)
            }
          }
          .padding(.horizontal, 16)
          Divider()
        }
      }
    }
  }
}
