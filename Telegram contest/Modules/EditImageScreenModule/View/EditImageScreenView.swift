//
//  EditImageScreenView.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 15.10.2022.
//

import UIKit

/// Events that we send from View to Presenter
protocol EditImageScreenViewOutput: AnyObject {}

/// Events that we send from Presenter to View
protocol EditImageScreenViewInput: AnyObject {}

/// Protocol alias UIView & EditImageScreenViewInput
typealias EditImageScreenViewProtocol = UIView & EditImageScreenViewInput

/// View for the screen
final class EditImageScreenView: EditImageScreenViewProtocol {
  
  // MARK: - Internal properties
  
  weak var output: EditImageScreenViewOutput?
  
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

private extension EditImageScreenView {
  func configureLayout() {}
  
  func applyDefaultBehavior() {
    backgroundColor = TGColor.primaryWhite
  }
}

// MARK: - Appearance

private extension EditImageScreenView {
  struct Appearance {}
}
