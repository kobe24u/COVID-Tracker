//
//  OverviewContentBlockView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 7/9/21.
//

import SwiftUI

struct OverviewContentBlockView: View {
  @EnvironmentObject var recordsViewModel: RecordsViewModel
  var body: some View {
    ZStack(alignment: .leading) {
      Color(hex: "#cdedfe")
      VStack(alignment: .leading, spacing: 16) {
        header
        NumberBlock(
          num: recordsViewModel.newCases,
          description: "positive cases reported in the past 24 hours"
        )
        HStack {
          NumberBlock(
            num: recordsViewModel.ratCases,
            description: "RAT"
          )
          NumberBlock(
            num: recordsViewModel.pcrCases,
            description: "PCR"
          )
        }
        Spacer()
          .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
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
      
      HStack {
        Text("NSW COVID-19 update")
          .font(.system(size: 23))
          .fontWeight(.bold)
          .foregroundColor(Color(hex: "#011d63"))
        
        Spacer()
        
        Image("nsw_logo")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(height: 50)
      }
      
      Divider()
    }
  }
  
  
  private var footer: some View {
    HStack {
      Text("Call Service NSW 7am to 7pm, Monday to Friday and 9am to 5pm on weekends and public holidays on 137788")
        .font(.system(size: 10))
        .foregroundColor(Color(hex: "#011d63"))
      Spacer()
      Image("nsw_health")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 50)
    }
  }
}

