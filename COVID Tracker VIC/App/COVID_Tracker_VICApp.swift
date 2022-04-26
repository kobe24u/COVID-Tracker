//
//  COVID_Tracker_VICApp.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import SwiftUI

@main
struct COVID_Tracker_VICApp: App {
  @StateObject var recordsViewModel = RecordsViewModel()
  
  var body: some Scene {
      WindowGroup {
        RootTabView()
//          .onAppear { recordsViewModel.fetchRecords() }
          .environmentObject(recordsViewModel)
          .task {
            recordsViewModel.dispatch(action: .fetchRecords(
              type: .lga, url: URL(string: "https://jsonkeeper.com/b/2RWK")
                                                                 ))
          }
      }
  }
}
