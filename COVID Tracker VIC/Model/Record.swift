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
}

struct Record: RecordForm {
  let _id: Int
  let new: String
  let data_date: String
  let file_processed_date: String
  let active: String
  let cases: String
  
  var LGA: String?
  var LGADisplay: String?
  var postcode: String? = nil
  
  // Computed Properties
  var id: Int { _id }
  var newCasesInt: Int { Int(new) ?? 0 }
  var lgaString: String { LGADisplay ?? LGA ?? "" }
  var recordedDate: Date { data_date.toDate() ?? Date.daysAgo(value: 1)}
  var announcedDate: Date { file_processed_date.toDate() ?? Date.today }
  var riskLevel: Risk { Risk.riskAssessment(of: newCasesInt) } 
}

protocol RecordForm: Codable, Identifiable {
  var _id: Int { get }
  var new: String { get }
  var data_date: String { get }
  var file_processed_date: String { get }
  var active: String { get }
  var cases: String { get }
  var LGA: String? { get set }
  var LGADisplay: String? { get set }
  var postcode: String? { get set }
}
