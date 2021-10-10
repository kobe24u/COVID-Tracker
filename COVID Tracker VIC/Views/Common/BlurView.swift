//
//  BlurView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 10/10/21.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
  var style: UIBlurEffect.Style
  
  func makeUIView(context: Context) -> UIVisualEffectView {
    UIVisualEffectView(
      effect:
        UIBlurEffect(style: style)
    )
  }
  
  func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    
  }
}
