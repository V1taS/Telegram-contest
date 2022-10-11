//
//  MainScreenAssembly.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// Collector `MainScreen`
final class MainScreenAssembly {
  
  /// Collects the `MainScreen` module
  /// - Returns: The assembled module `MainScreen`
  func createModule() -> MainScreenModule {
    let interactor = MainScreenInteractor()
    let view = MainScreenView()
    let factory = MainScreenFactory()
    let presenter = MainScreenViewController(moduleView: view,
                                             interactor: interactor,
                                             factory: factory)
    
    view.output = presenter
    interactor.output = presenter
    factory.output = presenter
    return presenter
  }
}
