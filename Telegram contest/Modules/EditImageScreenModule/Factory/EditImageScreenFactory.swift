//
//  EditImageScreenFactory.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 15.10.2022.
//

import UIKit

/// Events that we send from the Factory to the Presenter
protocol EditImageScreenFactoryOutput: AnyObject {}

/// Events that are sent from the Presenter to the Factory
protocol EditImageScreenFactoryInput {}

/// Factory
final class EditImageScreenFactory: EditImageScreenFactoryInput {
  
  // MARK: - Internal properties
  
  weak var output: EditImageScreenFactoryOutput?
  
  // MARK: - Internal func
}

// MARK: - Appearance

private extension EditImageScreenFactory {
  struct Appearance {}
}
