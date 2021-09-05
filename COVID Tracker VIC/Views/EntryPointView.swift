//
//  EntryPointView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import SwiftUI

struct EntryPointView: View {
  @StateObject var apiCaller = APICaller()
  
  var body: some View {
    if apiCaller.isLoading {
      LoadingView()
    } else if apiCaller.errorMessage != nil {
      ErrorView(apiCaller: apiCaller)
    } else {
      LGAListView(records: apiCaller.lGARecords)
    }
  }
}
