//
//  MainScreenViewController.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit
import Photos

/// Events that we send from `current module` to `another module`
protocol MainScreenModuleOutput: AnyObject {
  
  /// An image has been selected
  /// - Parameters:
  ///  - image: Image
  ///  - indexPath: Image index
  func didSelectImage(_ image: UIImage?, at indexPath: IndexPath)
}

/// Events sent from `another module` to `current module`
protocol MainScreenModuleInput {
  
  /// Events that we send from `current module` to `another module`
  var moduleOutput: MainScreenModuleOutput? { get set }
}

/// Ready module `MainScreenModule`
typealias MainScreenModule = UIViewController & MainScreenModuleInput

/// Presenter
final class MainScreenViewController: MainScreenModule {
  
  // MARK: - Internal properties
  
  weak var moduleOutput: MainScreenModuleOutput?
  
  // MARK: - Private properties
  
  private let interactor: MainScreenInteractorInput
  private let moduleView: MainScreenViewProtocol
  private let factory: MainScreenFactoryInput
  
  // MARK: - Initialization
  
  /// - Parameters:
  ///  - moduleView: view
  ///  - interactor: interactor
  ///  - factory: factory
  init(moduleView: MainScreenViewProtocol,
       interactor: MainScreenInteractorInput,
       factory: MainScreenFactoryInput) {
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
    
    interactor.getContent()
  }
}

// MARK: - MainScreenViewOutput

extension MainScreenViewController: MainScreenViewOutput {
  func didSelectImage(_ image: UIImage?, at indexPath: IndexPath) {
    moduleOutput?.didSelectImage(image, at: indexPath)
  }
}

// MARK: - MainScreenInteractorOutput

extension MainScreenViewController: MainScreenInteractorOutput {
  func didReceive(allImages: PHFetchResult<PHAsset>) {
    moduleView.configureCellsWith(models: allImages)
  }
}

// MARK: - MainScreenFactoryOutput

extension MainScreenViewController: MainScreenFactoryOutput {}

// MARK: - Appearance

private extension MainScreenViewController {
  struct Appearance {}
}
