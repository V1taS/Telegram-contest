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
  
  private let mainGradientView = GradientView()
  private let topBorderGradientView = GradientView()
  private let bottomBorderGradientView = GradientView()
  
  private var mainGradientViewLeadingAnchor: NSLayoutConstraint?
  private var topBorderGradientViewLeadingAnchor: NSLayoutConstraint?
  private var bottomBorderGradientViewLeadingAnchor: NSLayoutConstraint?
  
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
    
    updateLocationForGradientView()
  }
}

// MARK: - Private

private extension ButtonView {
  func updateLocationForGradientView() {
    if mainGradientViewLeadingAnchor == nil {
      mainGradientViewLeadingAnchor = mainGradientView.leadingAnchor.constraint(
        equalTo: leadingAnchor,
        constant: -(bounds.width * Appearance().gradientleadingMultipleView)
      )
      mainGradientViewLeadingAnchor?.isActive = true
    }
    
    if topBorderGradientViewLeadingAnchor == nil {
      topBorderGradientViewLeadingAnchor = topBorderGradientView.leadingAnchor.constraint(
        equalTo: leadingAnchor,
        constant: -(bounds.width * Appearance().gradientleadingMultipleView)
      )
      topBorderGradientViewLeadingAnchor?.isActive = true
    }
    
    if bottomBorderGradientViewLeadingAnchor == nil {
      bottomBorderGradientViewLeadingAnchor = bottomBorderGradientView.leadingAnchor.constraint(
        equalTo: leadingAnchor,
        constant: -(bounds.width * Appearance().gradientleadingMultipleView)
      )
      bottomBorderGradientViewLeadingAnchor?.isActive = true
    }
  }
  
  func configureLayout() {
    let appearance = Appearance()
    
    [topBorderGradientView, mainGradientView, bottomBorderGradientView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      heightAnchor.constraint(equalToConstant: Appearance().contentHeight),
      topBorderGradientView.widthAnchor.constraint(equalTo: widthAnchor),
      topBorderGradientView.heightAnchor.constraint(equalToConstant: appearance.borderHeight),
      bottomBorderGradientView.widthAnchor.constraint(equalTo: widthAnchor),
      bottomBorderGradientView.heightAnchor.constraint(equalToConstant: appearance.borderHeight),
      mainGradientView.widthAnchor.constraint(equalTo: widthAnchor),
      
      topBorderGradientView.topAnchor.constraint(equalTo: topAnchor),
      mainGradientView.topAnchor.constraint(equalTo: topAnchor),
      mainGradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
      bottomBorderGradientView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func applyDefaultBehavior() {
    let appearance = Appearance()
    backgroundColor = TGColor.primaryBlue
    layer.cornerRadius = Appearance().cornerRadius
    setTitleColor(TGColor.primaryWhite, for: .normal)
    titleLabel?.font = TGFont.proTextSemibold17
    
    topBorderGradientView.applyGradient(colors: appearance.whiteGradientColor)
    mainGradientView.applyGradient(colors: appearance.whiteGradientColor)
    bottomBorderGradientView.applyGradient(colors: appearance.whiteGradientColor)
  }
}

// MARK: - Appearance

private extension ButtonView {
  struct Appearance {
    let borderHeight: CGFloat = 1.33
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
