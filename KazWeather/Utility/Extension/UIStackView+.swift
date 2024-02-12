//
//  UIStackView+.swift
//  KazWeather
//
//  Created by 원태영 on 2/12/24.
//

import UIKit

extension UIStackView {
  func clear() {
    self.arrangedSubviews.forEach {
      self.removeArrangedSubview($0)
      $0.removeFromSuperview()
    }
  }
}
