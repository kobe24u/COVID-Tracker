//
//  OverviewTabView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 7/9/21.
//

import SwiftUI

struct OverviewTabView: View {
  @EnvironmentObject var recordsViewModel: RecordsViewModel
  var body: some View {
      VStack {
        NavigationViewHeaderBlock()
        OverviewContentBlockView()
        Spacer()
      }
  }
}
