//
//  String+DateConverter.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Foundation

extension String {
  func toDate() -> Date? {
    let dateFormatter : DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    dateFormatter.timeZone = TimeZone(identifier: "Australia/Melbourne")
    return dateFormatter.date(from: self)
  }
}

extension Date {
  func toHumanFriendlyString() -> String {
    let dateFormatter : DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMM"
    dateFormatter.timeZone = TimeZone(identifier: "Australia/Melbourne")
    return dateFormatter.string(from: self)
  }
}
