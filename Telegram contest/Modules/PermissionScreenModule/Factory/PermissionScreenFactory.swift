//
//  PermissionScreenFactory.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// Events that we send from the Factory to the Presenter
protocol PermissionScreenFactoryOutput: AnyObject {}

/// Events that are sent from the Presenter to the Factory
protocol PermissionScreenFactoryInput {}

/// Factory
final class PermissionScreenFactory: PermissionScreenFactoryInput {
  
  // MARK: - Internal properties
  
  weak var output: PermissionScreenFactoryOutput?
  
  // MARK: - Internal func
}

// MARK: - Appearance

private extension PermissionScreenFactory {
  struct Appearance {}
}
