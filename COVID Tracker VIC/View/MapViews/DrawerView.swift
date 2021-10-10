//
//  DrawerView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 10/10/21.
//

import SwiftUI

struct DrawerView: View {
  @State var text: String
  
  var body: some View {
    VStack {
      Capsule()
        .fill(.white)
        .frame(width: 60, height: 4)
      
      TextField("Search...", text: $text)
        .padding(.vertical, 10)
        .padding(.horizontal)
        .opacity(0.7)
        .padding(12)
    }
  }
}
