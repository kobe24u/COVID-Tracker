//
//  ContentView.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
      Text("Hello, world!")
          .padding()
        .onAppear(perform: loadData)
  }
  
  func loadData() {
    guard let url = URL(string: "https://discover.data.vic.gov.au/api/3/action/datastore_search?resource_id=bc71e010-253a-482a-bdbc-d65d1befe526") else {
      return }
    
    URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
      guard let data = data, let decodedResponse = try? JSONDecoder().decode(LGAResponse.self, from: data) else {
        return }
      
      print(decodedResponse.result.records)
    }.resume()
  }
  
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
