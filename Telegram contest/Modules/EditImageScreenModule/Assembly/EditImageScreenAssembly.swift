//
//  EditImageScreenAssembly.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 15.10.2022.
//

import UIKit

/// Collector `EditImageScreen`
final class EditImageScreenAssembly {
  
  /// Collects the `EditImageScreen` module
  /// - Returns: The compiled `EditImageScreen` module
  func createModule() -> EditImageScreenModule {
    let interactor = EditImageScreenInteractor()
    let view = EditImageScreenView()
    let factory = EditImageScreenFactory()
    let presenter = EditImageScreenViewController(moduleView: view,
                                                  interactor: interactor,
                                                  factory: factory)
    
    view.output = presenter
    interactor.output = presenter
    factory.output = presenter
    return presenter
  }
}
