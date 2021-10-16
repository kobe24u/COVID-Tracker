//
//  MapDrawerSiteDetailsView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 16/10/21.
//

import SwiftUI

struct MapDrawerSiteDetailsView: View {
  @Environment(\.openURL) var openURL
  var site: SiteType
  
  var body: some View {
    Text(site.name)
      .font(.headline)
    
    Text(site.fullAddress)
      .font(.subheadline)
  
    if let phoneNumberString = site.phone {
      Button(action: {
          let telephone = "tel://"
          let formattedString = telephone + phoneNumberString
          guard let url = URL(string: formattedString) else { return }
          UIApplication.shared.open(url)
         }) {
         Text(phoneNumberString)
      }
    }
    
    if let websiteString = site.website,
       let webSiteURL = URL(string: websiteString) {
      Button("Book Online") {
          openURL(webSiteURL)
      }
    }
    
    Text(site.availability)
      .font(.footnote)
  }
}
