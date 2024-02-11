//
//  UIView+.swift
//  KazWeather
//
//  Created by 원태영 on 2/11/24.
//

import UIKit

extension UIView {
  func addSubviews(_ view: UIView...) {
    view.forEach { self.addSubview($0) }
  }
}

