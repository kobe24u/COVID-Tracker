//
//  MapTypePicker.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 10/10/21.
//

import SwiftUI

struct MapTypePicker: View {
  @EnvironmentObject var mapViewModel: MapViewModel
  var body: some View {
    Picker("Current selected map type", selection: $mapViewModel.mapType) {
      ForEach(MapType.allCases, id: \.self) {
        Text($0.rawValue)
      }
    }.onChange(of: mapViewModel.mapType) { value in
      mapViewModel.sites.removeAll()
      mapViewModel.site = nil
      Task {
        await mapViewModel.asyncFetchMapData(of: value)
      }
    }
    .pickerStyle(SegmentedPickerStyle())
    .padding(.horizontal, 16)
  }
}
