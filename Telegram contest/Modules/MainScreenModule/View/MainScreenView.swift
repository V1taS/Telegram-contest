//
//  MainScreenView.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// Events that we send from View to Presenter
protocol MainScreenViewOutput: AnyObject {}

/// Events that we send from Presenter to View
protocol MainScreenViewInput: AnyObject {}

/// Protocol alias UIView & MainScreenViewInput
typealias MainScreenViewProtocol = UIView & MainScreenViewInput

/// View for the screen
final class MainScreenView: MainScreenViewProtocol {
  
  // MARK: - Internal properties
  
  weak var output: MainScreenViewOutput?
  
  // MARK: - Private properties
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureLayout()
    applyDefaultBehavior()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Internal func
}

// MARK: - Private

private extension MainScreenView {
  func configureLayout() {
    // TODO: - ...
  }
  
  func applyDefaultBehavior() {
    backgroundColor = .red
  }
}

// MARK: - Appearance

private extension MainScreenView {
  struct Appearance {}
}
