//
//  PermissionScreenCoordinator.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// Events that we send from `current coordinator` to `another coordinator`
protocol PermissionScreenCoordinatorOutput: AnyObject {
  
  /// Gallery accessed
  func requestPhotosSuccess()
}

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
  
  private let rootViewController: UIViewController
  private var permissionScreenModule: PermissionScreenModule?
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
    let permissionScreenModule = PermissionScreenAssembly().createModule(permissionService: services.permissionService)
    self.permissionScreenModule = permissionScreenModule
    self.permissionScreenModule?.moduleOutput = self
    permissionScreenModule.modalPresentationStyle = .fullScreen
    
    rootViewController.present(permissionScreenModule, animated: false)
  }
}

// MARK: - PermissionScreenModuleOutput

extension PermissionScreenCoordinator: PermissionScreenModuleOutput {
  func requestPhotosSuccess() {
    permissionScreenModule?.dismiss(animated: false) { [weak self] in
      guard let self = self else {
        return
      }
      self.output?.requestPhotosSuccess()
    }
  }
  
  func requestPhotosError() {
    photosErrorTextAlert()
  }
}

// MARK: - Private

private extension PermissionScreenCoordinator {
  func photosErrorTextAlert() {
    let appearance = Appearance()
    let alert = UIAlertController(title: appearance.titleErrorText + "?",
                                  message: "",
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: appearance.cancelErrorText,
                                  style: .cancel,
                                  handler: { _ in }))
    alert.addAction(UIAlertAction(title: appearance.okErrorText,
                                  style: .default,
                                  handler: { _ in
      guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
        return
      }
      UIApplication.shared.open(settingsUrl)
    }))
    permissionScreenModule?.present(alert, animated: true, completion: nil)
  }
}

// MARK: - Appearance

private extension PermissionScreenCoordinator {
  struct Appearance {
    let titleErrorText = "Share the gallery"
    let okErrorText = "Ok"
    let cancelErrorText = "Cancel"
  }
}
