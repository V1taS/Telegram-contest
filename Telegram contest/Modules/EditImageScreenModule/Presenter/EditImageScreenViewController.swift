//
//  EditImageScreenViewController.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 15.10.2022.
//

import UIKit

/// Events that we send from `current module` to `another module`
protocol EditImageScreenModuleOutput: AnyObject {}

/// Events sent from `another module` to `current module`
protocol EditImageScreenModuleInput {
  
  /// Events that we send from `current module` to `another module`
  var moduleOutput: EditImageScreenModuleOutput? { get set }
}

/// Ready module `EditImageScreenModule`
typealias EditImageScreenModule = UIViewController & EditImageScreenModuleInput

/// Presenter
final class EditImageScreenViewController: EditImageScreenModule {
  
  // MARK: - Internal properties
  
  weak var moduleOutput: EditImageScreenModuleOutput?
  
  // MARK: - Private properties
  
  private let interactor: EditImageScreenInteractorInput
  private let moduleView: EditImageScreenViewProtocol
  private let factory: EditImageScreenFactoryInput
  
  // MARK: - Initialization
  
  /// - Parameters:
  ///  - moduleView: view
  ///  - interactor: interactor
  ///  - factory: factory
  init(moduleView: EditImageScreenViewProtocol,
       interactor: EditImageScreenInteractorInput,
       factory: EditImageScreenFactoryInput) {
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
    
  }
}

// MARK: - EditImageScreenViewOutput

extension EditImageScreenViewController: EditImageScreenViewOutput {}

// MARK: - EditImageScreenInteractorOutput

extension EditImageScreenViewController: EditImageScreenInteractorOutput {}

// MARK: - EditImageScreenFactoryOutput

extension EditImageScreenViewController: EditImageScreenFactoryOutput {}

// MARK: - Appearance

private extension EditImageScreenViewController {
  struct Appearance {}
}
