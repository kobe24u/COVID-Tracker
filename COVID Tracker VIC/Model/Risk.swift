//
//  Severity.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import SwiftUI

enum Risk {
  case none
  case Low
  case Medium
  case High
  case Overwhelmed
  
  // Reference: https://www.bbc.com/news/explainers-52634739
  static func riskAssessment(of newCases: Int) -> Risk {
    switch newCases {
    case 0: return none
    case 1...10: return Low
    case 11...30: return Medium
    case 31...80: return High
    case 81...: return Overwhelmed
    default: fatalError("Invalid int value")
    }
  }
  
  var promptColor: Color {
    switch self {
    case .none: return Color(hex: "#578300")
    case .Low: return Color(hex: "#06BD8E")
    case .Medium: return Color(hex: "#F9AB17")
    case .High: return Color(hex: "#D56906")
    case .Overwhelmed: return Color(hex: "#990000")
    }
  }
}
