//
//  ContentView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import SwiftUI

struct LGAListView: View {
  let records: [LGARecord]
  
  var body: some View {
    List {
      ForEach(records) { record in
        Text(record.suburb)
      }
    }
  }
}

