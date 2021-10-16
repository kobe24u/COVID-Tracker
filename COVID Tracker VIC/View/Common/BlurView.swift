//
//  BlurView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 10/10/21.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
  @Environment(\.colorScheme) var colorScheme
  var style: UIBlurEffect.Style {
    colorScheme == .dark ? .dark : .light
  }
  
  func makeUIView(context: Context) -> UIVisualEffectView {
    UIVisualEffectView(
      effect:
        UIBlurEffect(style: style)
    )
  }
  
  func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    
  }
}
