//
//  ListRow.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 8/9/21.
//

import SwiftUI

struct ListRow: View {
  let record: Record
  let titleString: String

  var body: some View {
    HStack() {
      Text(titleString)
        .font(.system(size: 18, weight: .semibold))
      Spacer()
      Text("\(record.newCasesInt) New Cases")
        .font(.system(size: 15, weight: .bold))
        .foregroundColor(record.riskLevel.promptColor)
    }
  }
}
