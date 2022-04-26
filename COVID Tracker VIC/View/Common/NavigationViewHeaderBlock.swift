//
//  NavigationViewHeaderBlock.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 7/9/21.
//

import SwiftUI

struct NavigationViewHeaderBlock: View {
  let date: Date = Date()
  
  var body: some View {
    VStack {
      Text(date.toFullDateFormat())
        .font(.subheadline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
        .foregroundColor(.secondary)
      
      HStack {
        Text(date.toWeekDayFormat())
          .font(.title)
          .bold()
          .padding(.leading)
        
        Spacer()
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(.top, 32)
  }
}
