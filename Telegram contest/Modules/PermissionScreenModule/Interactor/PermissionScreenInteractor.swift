//
//  PermissionScreenInteractor.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// Events that we send from Interactor to Presenter
protocol PermissionScreenInteractorOutput: AnyObject {}

/// Events sent from Presenter to Interactor
protocol PermissionScreenInteractorInput {}

/// Interactor
final class PermissionScreenInteractor: PermissionScreenInteractorInput {
  
  // MARK: - Internal properties
  
  weak var output: PermissionScreenInteractorOutput?
  
  // MARK: - Internal func
}

// MARK: - Appearance

private extension PermissionScreenInteractor {
  struct Appearance {}
}
