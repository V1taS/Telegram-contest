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
  private let navigationController = UINavigationController()
  private var coordinator: Coordinator?
  private let services: ApplicationServices = ApplicationServicesImpl()
  
  
  // MARK: - Initialization
  
  /// - Parameter window: UIWindow
  init(window: UIWindow) {
    self.window = window
  }
  
  // MARK: - Internal func
  
  func start() {
    let mainScreenCoordinator: Coordinator = MainScreenCoordinator(navigationController, services)
    self.coordinator = mainScreenCoordinator
    mainScreenCoordinator.start()
    
    window.makeKeyAndVisible()
    window.rootViewController = navigationController
  }
}
