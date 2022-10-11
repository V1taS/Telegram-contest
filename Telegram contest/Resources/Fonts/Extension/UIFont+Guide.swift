//
//  UIFont+Guide.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

/// Extension for `UIFont`
extension UIFont {
  
  /// List of `TGFont` colors
  class var telegramFont: FontGuide { fontGuide }
}

// MARK: - Public property

var TGFont: FontGuide { fontGuide }

// MARK: - Private property

private let fontGuide = FontGuide()
