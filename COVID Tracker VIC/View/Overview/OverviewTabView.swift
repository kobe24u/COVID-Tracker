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
    switch recordsViewModel.viewState {
    case .loading: ProgressView()
    case .error(let errMsg): ErrorView(errorMessage: errMsg)
    case .results(_): contentView
    case .idle: EmptyView()
    }
  }
  
  @ViewBuilder private var contentView: some View {
    VStack {
      NavigationViewHeaderBlock()
      OverviewContentBlockView()
      Spacer()
    }
  }
}
