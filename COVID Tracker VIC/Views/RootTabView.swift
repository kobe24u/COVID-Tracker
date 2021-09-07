//
//  RootTabView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 7/9/21.
//

import SwiftUI

struct RootTabView: View {
  @EnvironmentObject var recordsProvider: RecordsProvider
    var body: some View {
      TabView {
        OverviewTabView()
          .tabItem {
            Image(systemName: "house.fill")
            Text("Overview")
          }
        RecordsContentView()
          .tabItem {
            Image(systemName: "list.bullet")
            Text("List")
          }
      }
    }
}

