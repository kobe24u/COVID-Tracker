//
//  SearchBar.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 6/9/21.
//

import SwiftUI

// Used to filter the item in a List
struct SearchBar : View {
  @Binding var searchTerm : String
  @State var showCancelButton = false

  var body: some View {
    HStack {
      HStack {
        Image(systemName: "magnifyingglass")
        
        TextField("Search", text: self.$searchTerm, onEditingChanged: { self.showCancelButton = $0 })
          .foregroundColor(.primary)
        
        Button(action: {
            self.searchTerm = ""
        }) {
            Image(systemName: "xmark.circle.fill").opacity(self.searchTerm == "" ? 0 : 1)
        }
      }
      .padding(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4))
      .foregroundColor(.secondary)
      .background(Color(.secondarySystemBackground))
      .cornerRadius(10.0)
      
      if self.showCancelButton {
          Button("Cancel") {
              UIApplication.shared.endEditing(true)
              self.searchTerm = ""
              self.showCancelButton = false
          }
          .foregroundColor(Color(.systemBlue))
      }
    }
    .padding(.horizontal)
  }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}
