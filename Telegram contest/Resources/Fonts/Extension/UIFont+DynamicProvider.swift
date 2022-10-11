//
//  UIFont+DynamicProvider.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

extension UIFont {
  static func get(font: FontToken) -> UIFont {
    switch font {
    case .proTextSemibold17:
      return UIFont(name: "SFProTextSemibold17", size: 17) ?? defaultFont(17, .semibold)
    case .proDisplaySemibold20:
      return UIFont(name: "SFProDisplay-Semibold", size: 20) ?? defaultFont(20, .semibold)
    }
  }
  
  // MARK: - Private func
  
  private static func defaultFont(_ size: CGFloat,
                                  _ weight: UIFont.Weight) -> UIFont {
    return UIFont.systemFont(ofSize: size, weight: weight)
  }
}
