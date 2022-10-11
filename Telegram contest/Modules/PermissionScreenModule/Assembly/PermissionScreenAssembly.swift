//
//  PermissionScreenAssembly.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// Collector `PermissionScreen`
final class PermissionScreenAssembly {
  
  /// Collects the `PermissionScreen` module
  /// - Returns: Built module `PermissionScreen`
  func createModule() -> PermissionScreenModule {
    let interactor = PermissionScreenInteractor()
    let view = PermissionScreenView()
    let factory = PermissionScreenFactory()
    let presenter = PermissionScreenViewController(moduleView: view,
                                                   interactor: interactor,
                                                   factory: factory)
    
    view.output = presenter
    interactor.output = presenter
    factory.output = presenter
    return presenter
  }
}
