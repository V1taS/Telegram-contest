//
//  MainScreenFactory.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// Events that we send from the Factory to the Presenter
protocol MainScreenFactoryOutput: AnyObject {}

/// Events that are sent from the Presenter to the Factory
protocol MainScreenFactoryInput {}

/// Factory
final class MainScreenFactory: MainScreenFactoryInput {
  
  // MARK: - Internal properties
  
  weak var output: MainScreenFactoryOutput?
  
  // MARK: - Internal func
}

// MARK: - Appearance

private extension MainScreenFactory {
  struct Appearance {}
}
