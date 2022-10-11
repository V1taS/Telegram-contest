//
//  MainScreenInteractor.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// Events that we send from Interactor to Presenter
protocol MainScreenInteractorOutput: AnyObject {}

/// Events sent from Presenter to Interactor
protocol MainScreenInteractorInput {}

/// Interactor
final class MainScreenInteractor: MainScreenInteractorInput {
  
  // MARK: - Internal properties
  
  weak var output: MainScreenInteractorOutput?
  
  // MARK: - Internal func
}

// MARK: - Appearance

private extension MainScreenInteractor {
  struct Appearance {}
}
