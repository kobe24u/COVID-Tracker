//
//  MVIViewModel.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 26/4/2022.
//

import Foundation

protocol ViewState {}

protocol Action {}

@MainActor
protocol MVIViewModel: ObservableObject {
  associatedtype S: ViewState
  associatedtype A: Action

  var viewState: S { get set }

  func reduce(currentState: S, action: A) -> S
  func runSideEffect(action: A, currentState: S)
}

extension MVIViewModel {
  func dispatch(action: A) {
    let newState = self.reduce(currentState: self.viewState, action: action)
    self.viewState = newState
    self.runSideEffect(action: action, currentState: newState)
  }
}
