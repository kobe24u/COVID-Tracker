//
//  ErrorView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import SwiftUI

struct ErrorView: View {
  @ObservedObject var apiCaller: APICaller
  
  var body: some View {
    VStack {
      Text("🦠, \(apiCaller.errorMessage ?? "")")
    }
  }
}
