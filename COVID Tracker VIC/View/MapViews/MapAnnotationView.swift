//
//  MapAnnotationView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 10/10/21.
//

import SwiftUI

struct MapAnnotationView: View {
  let mapType: MapType
  
  var body: some View {
    Group {
      if mapType == .testSites {
        Image(systemName: "testtube.2")
      } else {
        Image("vaxIcon")
          .renderingMode(.template)
          .resizable()
          .frame(width: 20, height: 20)
      }
    }
    .foregroundColor(.red)
    .padding(5)
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
    .overlay(
        Image(systemName: "arrowtriangle.left.fill")
            .rotationEffect(Angle(degrees: 270))
            .foregroundColor(.white)
            .offset(y: 10)
        ,
        alignment: .bottom
    )
  }
}
