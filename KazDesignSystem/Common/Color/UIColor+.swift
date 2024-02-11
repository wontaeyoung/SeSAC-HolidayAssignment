//
//  UIColor+.swift
//  KazDesignSystem
//
//  Created by 원태영 on 2/11/24.
//

import UIKit

extension UIColor {
  convenience init(hex: Int, opacity: CGFloat = 1.0) {
    let red = CGFloat((hex >> 16) & 0xff) / 255.0
    let green = CGFloat((hex >> 8) & 0xff) / 255.0
    let blue = CGFloat((hex >> 0) & 0xff) / 255.0
    
    self.init(red: red, green: green, blue: blue, alpha: opacity)
  }
  
  convenience init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
    let g = CGFloat((rgb >>  8) & 0xFF) / 255.0
    let b = CGFloat((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b, alpha: 1.0)
  }
}

extension UIColor {
  public static let weatherBackground = UIColor(hex: "1B1C1C")
  public static let weatherForeground = UIColor(hex: "FEFFFF")
  public static let weatherBrand = UIColor(hex: "FFD100")
  
  public static let borderColor = UIColor.gray.withAlphaComponent(0.5)
}
