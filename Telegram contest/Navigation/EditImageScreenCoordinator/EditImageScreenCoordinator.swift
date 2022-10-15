//
//  EditImageScreenCoordinator.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 15.10.2022.
//

import UIKit

/// Events that we send from `current coordinator` to `another coordinator`
protocol EditImageScreenCoordinatorOutput: AnyObject {}

/// Events that we send from `other coordinator` to `current coordinator`
protocol EditImageScreenCoordinatorInput {
  
  /// Events that we send from `current coordinator` to `another coordinator`
  var output: EditImageScreenCoordinatorOutput? { get set }
}

typealias EditImageScreenCoordinatorProtocol = EditImageScreenCoordinatorInput & Coordinator

final class EditImageScreenCoordinator: EditImageScreenCoordinatorProtocol {
  
  // MARK: - Internal variables
  
  weak var output: EditImageScreenCoordinatorOutput?
  
  // MARK: - Private variables
  
  private let rootViewController: UIViewController
  private var editImageScreenModule: EditImageScreenModule?
  private let services: ApplicationServices
  
  // MARK: - Initialization
  
  /// - Parameters:
  ///  - rootViewController: UINavigationController
  ///  - services: Application services
  init(_ rootViewController: UIViewController,
       _ services: ApplicationServices) {
    self.rootViewController = rootViewController
    self.services = services
  }
  
  // MARK: - Internal func
  
  func start() {
    let editImageScreenModule = EditImageScreenAssembly().createModule()
    self.editImageScreenModule = editImageScreenModule
    self.editImageScreenModule?.moduleOutput = self
    editImageScreenModule.modalPresentationStyle = .fullScreen
    
    rootViewController.present(editImageScreenModule, animated: true)
  }
}

// MARK: - PermissionScreenModuleOutput

extension EditImageScreenCoordinator: EditImageScreenModuleOutput {}

// MARK: - Private

private extension EditImageScreenCoordinator {}

// MARK: - Appearance

private extension EditImageScreenCoordinator {
  struct Appearance {}
}
