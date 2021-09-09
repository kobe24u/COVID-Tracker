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
  let _id: Int
  let new: String
  let data_date: String
  let file_processed_date: String
  let active: String
  let cases: String
  let LGA: String?
  let LGADisplay: String?
  let postcode: String?
  
  // Computed Properties
  var id: Int { _id }
  var newCasesInt: Int { Int(new) ?? 0 }
  var activeCasesInt: Int { Int(active) ?? 0 }
  var lgaString: String { LGADisplay ?? LGA ?? "" }
  var postCodeString: String { postcode ?? "" }
  var recordedDate: Date { data_date.toDate() ?? Date.daysAgo(value: 1)}
  var announcedDate: Date { file_processed_date.toDate() ?? Date.today }
  var riskLevel: Risk { Risk.riskAssessment(of: newCasesInt) } 
}
