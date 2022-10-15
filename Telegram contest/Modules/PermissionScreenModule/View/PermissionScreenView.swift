//
//  PermissionScreenView.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit
import Lottie

/// Events that we send from View to Presenter
protocol PermissionScreenViewOutput: AnyObject {
  
  /// The button was pressed
  func buttonAction()
}

/// Events that we send from Presenter to View
protocol PermissionScreenViewInput: AnyObject {
  
  /// Start logo animation
  func startAnimationLogoView()
  
  /// Stop animation for logo
  func stopAnimationLogoView()
}

/// Protocol alias UIView & PermissionScreenViewInput
typealias PermissionScreenViewProtocol = UIView & PermissionScreenViewInput

/// View for the screen
final class PermissionScreenView: PermissionScreenViewProtocol {
  
  // MARK: - Internal properties
  
  weak var output: PermissionScreenViewOutput?
  
  // MARK: - Private properties
  
  private let containerView = UIView()
  private let buttonView = ButtonView()
  private let titleLabel = UILabel()
  private let logoImageView = LottieAnimationView(name: Appearance().animationImage)
  
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
  
  func startAnimationLogoView() {
    logoImageView.play()
  }
  
  func stopAnimationLogoView() {
    logoImageView.stop()
  }
}

// MARK: - Private

private extension PermissionScreenView {
  func configureLayout() {
    let appearance = Appearance()
    
    [logoImageView, titleLabel, buttonView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      containerView.addSubview($0)
    }
    
    [containerView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      logoImageView.widthAnchor.constraint(equalToConstant: appearance.logoImageSize.width),
      logoImageView.heightAnchor.constraint(equalToConstant: appearance.logoImageSize.height),
      
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
      logoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      
      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                          constant: appearance.minInset),
      titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,
                                      constant: appearance.middleInset),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                           constant: -appearance.minInset),
      
      buttonView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                          constant: appearance.minInset),
      buttonView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                      constant: appearance.largeInset),
      buttonView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                           constant: -appearance.minInset),
      buttonView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
    ])
  }
  
  func applyDefaultBehavior() {
    let appearance = Appearance()
    
    backgroundColor = TGColor.primaryWhite
    buttonView.setTitle(appearance.buttonText, for: .normal)
    
    titleLabel.font = TGFont.proDisplaySemibold20
    titleLabel.textAlignment = .center
    titleLabel.text = appearance.titleText
    titleLabel.textColor = TGColor.primaryBlack
    
    logoImageView.contentMode = .scaleAspectFit
    logoImageView.loopMode = .loop
    logoImageView.animationSpeed = appearance.animationSpeed
    
    buttonView.addTarget(self, action: #selector(buttonViewAction), for: .touchUpInside)
  }
  
  @objc
  func buttonViewAction() {
    output?.buttonAction()
  }
}

// MARK: - Appearance

private extension PermissionScreenView {
  struct Appearance {
    let titleText = "Access Your Photos and Videos"
    let buttonText = "Allow Access"
    let animationSpeed = 0.5
    
    let minInset: CGFloat = 16
    let middleInset: CGFloat = 20
    let largeInset: CGFloat = 28
    let logoImageSize = CGSize(width: 144, height: 144)
    let animationImage = "duck"
  }
}
