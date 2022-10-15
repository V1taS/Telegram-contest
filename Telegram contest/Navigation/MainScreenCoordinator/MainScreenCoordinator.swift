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
  
  private let rootViewController: UIViewController
  private var mainScreenModule: MainScreenModule?
  private var coordinator: Coordinator?
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
    let mainScreenModule = MainScreenAssembly().createModule()
    self.mainScreenModule = mainScreenModule
    self.mainScreenModule?.moduleOutput = self
    
    mainScreenModule.modalPresentationStyle = .fullScreen
    rootViewController.present(mainScreenModule, animated: false)
  }
}

// MARK: - MainScreenModuleOutput

extension MainScreenCoordinator: MainScreenModuleOutput {
  func didSelectImage(_ image: UIImage?, at indexPath: IndexPath) {
    startEditImageScreenCoordinator()
  }
}

// MARK: - EditImageScreenCoordinatorOutput

extension MainScreenCoordinator: EditImageScreenCoordinatorOutput {}

// MARK: - Private

private extension MainScreenCoordinator {
  func startEditImageScreenCoordinator() {
    guard let upperViewController = mainScreenModule else {
      return
    }
    
    let editImageScreenCoordinator = EditImageScreenCoordinator(upperViewController, services)
    self.coordinator = editImageScreenCoordinator
    editImageScreenCoordinator.output = self
    editImageScreenCoordinator.start()
  }
}
