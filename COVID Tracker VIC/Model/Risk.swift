//
//  Severity.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import SwiftUI

enum Risk {
  case none
  case low
  case medium
  case high
  case overwhelmed
  
  // Reference: https://www.bbc.com/news/explainers-52634739
  static func riskAssessment(of newCases: Int) -> Risk {
    switch newCases {
    case 0: return none
    case 1...10: return low
    case 11...30: return medium
    case 31...80: return high
    case 81...: return overwhelmed
    default: fatalError("Invalid int value")
    }
  }
  
  var promptColor: Color {
    switch self {
    case .none: return Color(hex: "#578300")
    case .low: return Color(hex: "#06BD8E")
    case .medium: return Color(hex: "#F9AB17")
    case .high: return Color(hex: "#D56906")
    case .overwhelmed: return Color(hex: "#990000")
    }
  }
}
