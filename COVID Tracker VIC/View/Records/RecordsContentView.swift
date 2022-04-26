//
//  EntryPointView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import SwiftUI

struct RecordsContentView: View {
  @EnvironmentObject var recordsViewModel: RecordsViewModel
  
  var body: some View {
    switch recordsViewModel.viewState {
    case .loading: ProgressView()
    case .error(let errMsg): ErrorView(errorMessage: errMsg)
    case .results(_): RecordsListView()
    case .idle: EmptyView()
    }
  }
}
