//
//  ErrorView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import SwiftUI

struct ErrorView: View {
  let errorMessage: String
  
  var body: some View {
    VStack {
      Text("🦠, \(errorMessage)")
    }
  }
}
