//
//  UIColor+Guide.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// Extension for `UIColor`
extension UIColor {
  
  /// List of `TGColor` colors
  class var telegramColor: ColorGuide { colorGuide }
}

// MARK: - Public property

var TGColor: ColorGuide { colorGuide }

// MARK: - Private property

private let colorGuide = ColorGuide()
