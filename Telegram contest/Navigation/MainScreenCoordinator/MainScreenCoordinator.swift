//
//  MainScreenCoordinator.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// Events that we send from `current coordinator` to `another coordinator`
protocol MainScreenCoordinatorOutput: AnyObject {}

/// Events that we send from `other coordinator` to `current coordinator`
protocol MainScreenCoordinatorInput {
  
  /// Events that we send from `current coordinator` to `another coordinator`
  var output: MainScreenCoordinatorOutput? { get set }
}

typealias MainScreenCoordinatorProtocol = MainScreenCoordinatorInput & Coordinator

final class MainScreenCoordinator: MainScreenCoordinatorProtocol {
  
  // MARK: - Internal variables
  
  weak var output: MainScreenCoordinatorOutput?
  
  // MARK: - Private variables
  
  private let upperViewController: UIViewController
  private var mainScreenModule: MainScreenModule?
  private var anyCoordinator: AnyObject?
  private let services: ApplicationServices
  
  // MARK: - Initialization
  
  /// - Parameters:
  ///  - upperViewController: UINavigationController
  ///  - services: Application services
  init(_ upperViewController: UIViewController,
       _ services: ApplicationServices) {
    self.upperViewController = upperViewController
    self.services = services
  }
  
  // MARK: - Internal func
  
  func start() {
    let mainScreenModule = MainScreenAssembly().createModule()
    self.mainScreenModule = mainScreenModule
    self.mainScreenModule?.moduleOutput = self
    
    mainScreenModule.modalPresentationStyle = .fullScreen
    upperViewController.present(mainScreenModule, animated: false)
  }
}

// MARK: - MainScreenModuleOutput

extension MainScreenCoordinator: MainScreenModuleOutput {}

// MARK: - PermissionScreenCoordinatorOutput

extension MainScreenCoordinator: PermissionScreenCoordinatorOutput {}

// MARK: - Private

private extension MainScreenCoordinator {
  func startPermissionScreenCoordinator() {
    guard let upperViewController = mainScreenModule else {
      return
    }
    
    let permissionScreenCoordinator = PermissionScreenCoordinator(upperViewController,
                                                                  services)
    permissionScreenCoordinator.output = self
    anyCoordinator = permissionScreenCoordinator
    permissionScreenCoordinator.start()
  }
}
