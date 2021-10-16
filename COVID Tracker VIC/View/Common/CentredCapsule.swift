//
//  CentredCapsucle.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 16/10/21.
//

import SwiftUI

struct CentredCapsule: View {
  var body: some View {
    HStack {
      Spacer()
      Capsule()
        .fill(.white)
        .frame(width: 60, height: 4)
        .padding(.top)
      Spacer()
    }
  }
}

