//
//  RootCoordinator.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

final class RootCoordinator: Coordinator {
  
  // MARK: - Private variables
  
  private let window: UIWindow
  private let rootViewController = UIViewController()
  private var coordinator: Coordinator?
  private let services: ApplicationServices = ApplicationServicesImpl()
  
  // MARK: - Initialization
  
  /// - Parameter window: UIWindow
  init(window: UIWindow) {
    self.window = window
  }
  
  // MARK: - Internal func
  
  func start() {
    window.overrideUserInterfaceStyle = .dark
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
    
    DispatchQueue.main.async { [weak self] in
      guard let self = self else {
        return
      }
      self.checkAuthorizationStatus()
    }
  }
}

// MARK: - MainScreenCoordinatorOutput

extension RootCoordinator: MainScreenCoordinatorOutput {}

// MARK: - PermissionScreenCoordinatorOutput

extension RootCoordinator: PermissionScreenCoordinatorOutput {
  func requestPhotosSuccess() {
    startMainScreenCoordinator()
  }
}

// MARK: - Private

private extension RootCoordinator {
  func checkAuthorizationStatus() {
    if services.permissionService.isAuthorizationStatus() {
      startMainScreenCoordinator()
    } else {
      startPermissionScreenCoordinator()
    }
  }
  
  
  func startMainScreenCoordinator() {
    let mainScreenCoordinator = MainScreenCoordinator(rootViewController, services)
    self.coordinator = mainScreenCoordinator
    mainScreenCoordinator.output = self
    mainScreenCoordinator.start()
  }
  
  func startPermissionScreenCoordinator() {
    let permissionScreenCoordinator = PermissionScreenCoordinator(rootViewController, services)
    self.coordinator = permissionScreenCoordinator
    permissionScreenCoordinator.output = self
    permissionScreenCoordinator.start()
  }
}
