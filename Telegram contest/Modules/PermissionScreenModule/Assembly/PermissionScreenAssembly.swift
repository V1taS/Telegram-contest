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
  /// - Parameter permissionService: Service for working with permissions
  /// - Returns: Built module `PermissionScreen`
  func createModule(permissionService: PermissionService) -> PermissionScreenModule {
    let interactor = PermissionScreenInteractor(permissionService: permissionService)
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
