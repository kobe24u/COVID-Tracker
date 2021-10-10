//
//  OverviewContentBlockView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 7/9/21.
//

import SwiftUI

struct OverviewContentBlockView: View {
  let newCaseNum: Int
  let totalCaseNum: Int
  @Binding var isLoading: Bool
  var body: some View {
    ZStack(alignment: .leading) {
      Color(hex: "#014EA8")
      VStack(alignment: .leading, spacing: 16) {
        header
        HStack {
          NumberBlock(num: newCaseNum, description: "new cases", isLoading: $isLoading)
          NumberBlock(num: totalCaseNum, description: "total cases", isLoading: $isLoading)
        }
        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        Spacer()
        footer
      }
      .padding()
    }
    .background(Color(UIColor.systemGray2))
    .clipShape(RoundedRectangle(cornerRadius: 20))
    .padding(.all, 16)
  }
  
  private var header: some View {
    VStack(alignment: .leading, spacing: 16) {
      
      Text("CORONAVIRUS(COVID-19) IN VICTORIA")
        .font(.subheadline)
        .foregroundColor(.white)
      
      Text("LATEST NUMBERS")
        .font(.title)
        .foregroundColor(.white)
        .fontWeight(.bold)
    }
  }
  
  
  private var footer: some View {
    HStack {
      Text("Call the 24/7 Hotline on 1800 675 398 \n Or visit www.dhhs.vic.gov.au/coronavirus")
        .font(.system(size: 10))
        .foregroundColor(.white)
      Spacer()
      Image("dhhsvic")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 50)
    }
  }
}

