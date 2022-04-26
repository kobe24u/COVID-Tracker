//
//  LGARecord.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Foundation

struct Response: Codable {
  let result: Result
}

struct Result: Codable {
  let records: [Record]
  let _links: Link
  let total: Int
}

struct Link: Codable {
  let next: String
}

struct Record: Codable, Identifiable {
  let notification_date: String
  let confirmed_cases_count: String
  let lga_name19: String
  let confirmed_by_pcr: String
  let postcode: String

  // Computed Properties
  var id: String { UUID().uuidString }
  var pcr: Bool { confirmed_by_pcr == "Yes" ? true : false }
  var newCasesInt: Int { Int(confirmed_cases_count) ?? 0 }
  var lgaString: String { lga_name19 + " " +  postcode }
  var recordedDate: Date { notification_date.toDate() ?? Date.daysAgo(value: 1)}
  var riskLevel: Risk { Risk.riskAssessment(of: newCasesInt) }
}
