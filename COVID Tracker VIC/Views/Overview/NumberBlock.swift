//
//  NumberBlock.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 7/9/21.
//

import SwiftUI

struct NumberBlock: View {
  let num: Int
  let description: String
  @Binding var isLoading: Bool
  
  var body: some View {
    ZStack {
      Color(hex: "#4276BB")
      VStack {
        Group {
          if isLoading { ProgressView() } else {
            Text("\(num)")
              .font(.system(size: 30, weight: .black, design: .monospaced))
              .foregroundColor(.white)
          }
        }
        Text(description)
          .foregroundColor(.white)
      }
    }
    .ignoresSafeArea()
  }
}
