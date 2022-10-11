//
//  UIColor+DynamicProvider.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit

extension UIColor {
  convenience init(light: ColorToken, dark: ColorToken? = nil) {
    guard #available(iOS 13.0, *), let dark = dark else {
      self.init(hexString: light.rawValue)
      return
    }
    
    let lightColor = UIColor(hexString: light.rawValue)
    let darkColor = UIColor(hexString: dark.rawValue)
    
    self.init(dynamicProvider: {
      switch $0.userInterfaceStyle {
      case .light: return lightColor
      case .dark: return darkColor
      case .unspecified:
        fallthrough
      @unknown default:
        return lightColor
      }
    })
  }
}
