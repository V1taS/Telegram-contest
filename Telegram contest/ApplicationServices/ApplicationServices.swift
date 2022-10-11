//
//  ApplicationServices.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import Foundation

/// Protocol describing all system dependencies.
/// Designed to move away from the DI framework in favor of the Composition Root concept.
///
/// Reasons for not using DI:
/// 1. Use fewer third party dependencies
/// 2. Reducing the number of errors / crashes in the application, because strong typing is used for each dependency
///
/// You can read about the concept in [article](https://blog.ploeh.dk/2011/07/28/CompositionRoot/)
protocol ApplicationServices {
  
  /// Service for working with permissions
  var permissionService: PermissionService { get }
}

// MARK: - Implementation ApplicationServices

final class ApplicationServicesImpl: ApplicationServices {
  
  var permissionService: PermissionService {
    PermissionServiceImpl()
  }
}
