//
//  PermissionScreenCoordinator.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// Events that we send from `current coordinator` to `another coordinator`
protocol PermissionScreenCoordinatorOutput: AnyObject {}

/// Events that we send from `other coordinator` to `current coordinator`
protocol PermissionScreenCoordinatorInput {
  
  /// Events that we send from `current coordinator` to `another coordinator`
  var output: PermissionScreenCoordinatorOutput? { get set }
}

typealias PermissionScreenCoordinatorProtocol = PermissionScreenCoordinatorInput & Coordinator

final class PermissionScreenCoordinator: PermissionScreenCoordinatorProtocol {
  
  // MARK: - Internal variables
  
  weak var output: PermissionScreenCoordinatorOutput?
  
  // MARK: - Private variables
  
  private let upperViewController: UIViewController
  private var permissionScreenModule: PermissionScreenModule?
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
    let permissionScreenModule = PermissionScreenAssembly().createModule()
    self.permissionScreenModule = permissionScreenModule
    self.permissionScreenModule?.moduleOutput = self
    permissionScreenModule.modalPresentationStyle = .fullScreen
    
    upperViewController.present(permissionScreenModule, animated: false)
  }
}

// MARK: - PermissionScreenModuleOutput

extension PermissionScreenCoordinator: PermissionScreenModuleOutput {}
