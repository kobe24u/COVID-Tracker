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
  
  var body: some View {
    ZStack {
      Color(hex: "#002764")
      VStack {
        Text("\(num)")
          .font(.system(size: 40, weight: .black, design: .monospaced))
          .foregroundColor(.white)
        
        Text(description)
          .multilineTextAlignment(.center)
          .foregroundColor(.white)
      }
    }
    .ignoresSafeArea()
  }
}
