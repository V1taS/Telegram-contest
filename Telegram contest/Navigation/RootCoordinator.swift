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
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
    
    DispatchQueue.main.async { [weak self] in
      guard let self = self else {
        return
      }
      
      let permissionScreenCoordinator: Coordinator = PermissionScreenCoordinator(self.rootViewController, self.services)
      self.coordinator = permissionScreenCoordinator
      permissionScreenCoordinator.start()
    }
  }
}
