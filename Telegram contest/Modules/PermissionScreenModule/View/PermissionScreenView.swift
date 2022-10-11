//
//  PermissionScreenView.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// Events that we send from View to Presenter
protocol PermissionScreenViewOutput: AnyObject {}

/// Events that we send from Presenter to View
protocol PermissionScreenViewInput: AnyObject {}

/// Protocol alias UIView & PermissionScreenViewInput
typealias PermissionScreenViewProtocol = UIView & PermissionScreenViewInput

/// View for the screen
final class PermissionScreenView: PermissionScreenViewProtocol {
  
  // MARK: - Internal properties
  
  weak var output: PermissionScreenViewOutput?
  
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

private extension PermissionScreenView {
  func configureLayout() {
    
  }
  
  func applyDefaultBehavior() {
    backgroundColor = .white
  }
}

// MARK: - Appearance

private extension PermissionScreenView {
  struct Appearance {
    
  }
}
