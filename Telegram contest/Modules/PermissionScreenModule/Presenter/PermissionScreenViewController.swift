//
//  PermissionScreenViewController.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// Events that we send from `current module` to `another module`
protocol PermissionScreenModuleOutput: AnyObject {}

/// Events sent from `another module` to `current module`
protocol PermissionScreenModuleInput {
  
  /// Events that we send from `current module` to `another module`
  var moduleOutput: PermissionScreenModuleOutput? { get set }
}

/// Ready module `PermissionScreenModule`
typealias PermissionScreenModule = UIViewController & PermissionScreenModuleInput

/// Presenter
final class PermissionScreenViewController: PermissionScreenModule {
  
  // MARK: - Internal properties
  
  weak var moduleOutput: PermissionScreenModuleOutput?
  
  // MARK: - Private properties
  
  private let interactor: PermissionScreenInteractorInput
  private let moduleView: PermissionScreenViewProtocol
  private let factory: PermissionScreenFactoryInput
  
  // MARK: - Initialization
  
  /// - Parameters:
  ///  - moduleView: view
  ///  - interactor: interactor
  ///  - factory: factory
  init(moduleView: PermissionScreenViewProtocol,
       interactor: PermissionScreenInteractorInput,
       factory: PermissionScreenFactoryInput) {
    self.moduleView = moduleView
    self.interactor = interactor
    self.factory = factory
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Life cycle
  
  override func loadView() {
    view = moduleView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // TODO: - ...
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    moduleView.startAnimationLogoView()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    moduleView.stopAnimationLogoView()
  }
}

// MARK: - PermissionScreenViewOutput

extension PermissionScreenViewController: PermissionScreenViewOutput {}

// MARK: - PermissionScreenInteractorOutput

extension PermissionScreenViewController: PermissionScreenInteractorOutput {}

// MARK: - PermissionScreenFactoryOutput

extension PermissionScreenViewController: PermissionScreenFactoryOutput {}

// MARK: - Appearance

private extension PermissionScreenViewController {
  struct Appearance {}
}
