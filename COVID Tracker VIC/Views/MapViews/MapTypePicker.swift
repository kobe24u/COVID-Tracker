//
//  MapTypePicker.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 10/10/21.
//

import SwiftUI

struct MapTypePicker: View {
  @EnvironmentObject var mapViewProvider: MapViewProvider
  var body: some View {
    Picker("Current selected map type", selection: $mapViewProvider.mapType) {
      ForEach(MapType.allCases, id: \.self) {
        Text($0.rawValue)
      }
    }.onChange(of: mapViewProvider.mapType) { value in
      Task {
        await mapViewProvider.asyncFetchMapData(of: value)
      }
    }
    .pickerStyle(SegmentedPickerStyle())
    .padding(.horizontal, 16)
  }
}
