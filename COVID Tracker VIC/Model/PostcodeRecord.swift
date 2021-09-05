//
//  PostcodeRecord.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Foundation

struct PostcodeResponse: Codable {
  let result: PostcodeResult
}

struct PostcodeResult: Codable {
  let records: [PostcodeRecord]
}

struct PostcodeRecord: Codable {
  let _id: Int
  let postcode: String
  let active: String
  let cases: String
  let new: String
  private let data_date: String
  private let file_processed_date: String
  var recordedDate: Date { data_date.toDate() ?? Date.daysAgo(value: 1)}
  var announcedDate: Date { file_processed_date.toDate() ?? Date.today }
}
