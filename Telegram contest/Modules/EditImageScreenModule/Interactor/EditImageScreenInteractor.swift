//
//  EditImageScreenInteractor.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 15.10.2022.
//

import UIKit

/// Events that we send from Interactor to Presenter
protocol EditImageScreenInteractorOutput: AnyObject {}

/// Events sent from Presenter to Interactor
protocol EditImageScreenInteractorInput {}

/// Interactor
final class EditImageScreenInteractor: EditImageScreenInteractorInput {
  
  // MARK: - Internal properties
  
  weak var output: EditImageScreenInteractorOutput?
  
  // MARK: - Internal func
}

// MARK: - Appearance

private extension EditImageScreenInteractor {
  struct Appearance {}
}
