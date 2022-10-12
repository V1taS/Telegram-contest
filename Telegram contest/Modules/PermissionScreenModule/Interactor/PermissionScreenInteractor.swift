//
//  PermissionScreenInteractor.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// Events that we send from Interactor to Presenter
protocol PermissionScreenInteractorOutput: AnyObject {
  
  /// Gallery accessed
  func requestPhotosSuccess()
  
  /// Gallery not accessed
  func requestPhotosError()
}

/// Events sent from Presenter to Interactor
protocol PermissionScreenInteractorInput {
  
  /// Request access to the Gallery
  func requestPhotosStatus()
}

/// Interactor
final class PermissionScreenInteractor: PermissionScreenInteractorInput {
  
  // MARK: - Internal properties
  
  weak var output: PermissionScreenInteractorOutput?
  
  // MARK: - Private properties
  
  private let permissionService: PermissionService
  
  // MARK: - Initialization
  
  /// Initializer
  /// - Parameter permissionService: Service for working with permissions
  init(permissionService: PermissionService) {
    self.permissionService = permissionService
  }
  
  // MARK: - Internal func
  
  func requestPhotosStatus() {
    permissionService.requestPhotos { [weak self] granted in
      switch granted {
      case true:
        self?.output?.requestPhotosSuccess()
      case false:
        self?.output?.requestPhotosError()
      }
    }
  }
}

// MARK: - Appearance

private extension PermissionScreenInteractor {
  struct Appearance {}
}
