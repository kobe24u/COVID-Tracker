//
//  LGARecord.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Foundation

struct LGAResponse: Codable {
  let result: LGAResult
}

struct LGAResult: Codable {
  let records: [LGARecord]
}

struct LGARecord: Codable, Identifiable {
  let _id: Int
  let active: String
  let cases: String
  let new: String
  private let LGADisplay: String?
  private let data_date: String
  private let file_processed_date: String
  var id: Int { _id }
  var suburb: String { LGADisplay ?? "" }
  var recordedDate: Date { data_date.toDate() ?? Date.daysAgo(value: 1)}
  var announcedDate: Date { file_processed_date.toDate() ?? Date.today }
}
