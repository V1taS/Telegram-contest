//
//  ButtonView.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// View for the screen
final class ButtonView: UIButton {
  
  // MARK: - Private property
  
  private let gradientView = GradientView()
  private var gradientViewLeadingAnchor: NSLayoutConstraint?
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureLayout()
    applyDefaultBehavior()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    if gradientViewLeadingAnchor == nil {
      gradientViewLeadingAnchor = gradientView.leadingAnchor.constraint(
        equalTo: leadingAnchor,
        constant: -(bounds.width * Appearance().gradientleadingMultipleView)
      )
      gradientViewLeadingAnchor?.isActive = true
    }
  }
  
  // MARK: - Internal func
}

// MARK: - Private

private extension ButtonView {
  func configureLayout() {
    [gradientView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      heightAnchor.constraint(equalToConstant: Appearance().contentHeight),
      gradientView.widthAnchor.constraint(equalTo: widthAnchor),
      
      gradientView.topAnchor.constraint(equalTo: topAnchor),
      gradientView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func applyDefaultBehavior() {
    let appearance = Appearance()
    
    backgroundColor = TGColor.primaryBlue
    layer.cornerRadius = Appearance().cornerRadius
    setTitleColor(TGColor.primaryWhite, for: .normal)
    titleLabel?.font = TGFont.proTextSemibold17
    
    gradientView.applyGradient(colors: appearance.whiteGradientColor)
  }
}

// MARK: - Appearance

private extension ButtonView {
  struct Appearance {
    let contentHeight: CGFloat = 50
    let cornerRadius: CGFloat = 10
    let gradientleadingMultipleView = 0.25
    let whiteGradientColor = [
      UIColor.white.withAlphaComponent(.zero),
      UIColor.white.withAlphaComponent(0.85),
      UIColor.white.withAlphaComponent(1),
      UIColor.white.withAlphaComponent(0.85),
      UIColor.white.withAlphaComponent(.zero)
    ]
  }
}
