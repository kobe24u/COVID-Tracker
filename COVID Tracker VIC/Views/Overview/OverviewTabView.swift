//
//  OverviewTabView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 7/9/21.
//

import SwiftUI

struct OverviewTabView: View {
  @EnvironmentObject var recordsProvider: RecordsProvider
  var body: some View {
    VStack {
      NavigationViewHeaderBlock()
      OverviewContentBlockView(newCaseNum: recordsProvider.newCases, totalCaseNum: recordsProvider.activeCases, isLoading: $recordsProvider.isLoading)
      Spacer()
    }
  }
}

