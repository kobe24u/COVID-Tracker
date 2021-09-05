//
//  Date+Manipulation.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Foundation

extension Date {
  static var today: Date { Date() }
  
  static func daysAgo(value: Int) -> Date {
    Calendar.current.date(byAdding: .day, value: -value, to: today) ?? today
  }
}
