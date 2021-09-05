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
    NavigationView {
      List {
        ForEach(records) { record in
          HStack() {
            Text(record.suburb)
              .font(.system(size: 20, weight: .semibold))
            Spacer()
            Text("\(record.newCasesInt) New Cases")
              .font(.system(size: 15, weight: .bold))
              .foregroundColor(record.riskLevel.promptColor)
          }
        }
      }
      .navigationBarTitle(records[0].announcedDate.toHumanFriendlyString() + " 🦠 Update")
    }
  }
}

