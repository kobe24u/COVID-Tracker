//
//  LoadingView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import SwiftUI

struct LoadingView: View {
  var body: some View {
    VStack(spacing: 20) {
      Text("🦠")
        .font(.system(size: 80))
      ProgressView()
      Text("Fetching data...")
    }
  }
}
