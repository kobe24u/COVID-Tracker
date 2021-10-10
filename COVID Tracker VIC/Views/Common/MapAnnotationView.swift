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
    Image(systemName: mapType == .testSites ? "testtube.2" : "cross.case")
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
