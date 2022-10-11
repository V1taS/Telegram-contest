//
//  GradientView.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// View for the screen
final class GradientView: UIView {
  
  // MARK: - Internal properties
  
  override class var layerClass: AnyClass {
    return CAGradientLayer.self
  }
  
  // MARK: - Internal func
  
  func applyGradient(colors: [UIColor]) {
    let appearance = Appearance()
    guard let gradientLayer = layer as? CAGradientLayer else { return }
    
    gradientLayer.colors = colors.map { $0.cgColor }
    gradientLayer.locations = appearance.locations
    
    gradientLayer.startPoint = appearance.startPoint
    gradientLayer.endPoint = appearance.endPoint
    gradientLayer.compositingFilter = appearance.compositingFilter
  }
}

// MARK: - Appearance

private extension GradientView {
  struct Appearance {
    let locations: [NSNumber] = [0, 0.4, 0.52, 0.65, 1]
    let startPoint = CGPoint(x: 0.25, y: 0.5)
    let endPoint = CGPoint(x: 0.75, y: 0.5)
    let compositingFilter = "softLightBlendMode"
  }
}
