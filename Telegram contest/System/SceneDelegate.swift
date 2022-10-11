//
//  SceneDelegate.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  // MARK: - Private property
  
  private var coordinator: Coordinator?
  
  // MARK: - Internal property
  
  var window: UIWindow?
  
  // MARK: - Internal func
  
  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = scene as? UIWindowScene else { return }
    let window = UIWindow(windowScene: scene)
    let coordinator = RootCoordinator(window: window)
    self.coordinator = coordinator
    coordinator.start()
    self.window = window
  }
}
