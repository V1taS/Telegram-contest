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
  
  // MARK: - Private properties
  
  private let containerView = UIView()
  private let buttonView = ButtonView()
  
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
    [buttonView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      containerView.addSubview($0)
    }
    
    [containerView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      buttonView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
      buttonView.topAnchor.constraint(equalTo: containerView.topAnchor),
      buttonView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
      buttonView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
    ])
  }
  
  func applyDefaultBehavior() {
    backgroundColor = TGColor.primaryWhite
  }
}

// MARK: - Appearance

private extension PermissionScreenView {
  struct Appearance {
    
  }
}
