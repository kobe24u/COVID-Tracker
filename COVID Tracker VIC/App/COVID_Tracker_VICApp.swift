//
//  COVID_Tracker_VICApp.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import SwiftUI

@main
struct COVID_Tracker_VICApp: App {
  @StateObject var apiCaller = APICaller()
  
  var body: some Scene {
      WindowGroup {
        RecordsContentView(apiCaller: apiCaller)
      }
  }
}
