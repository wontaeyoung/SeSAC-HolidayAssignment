//
//  UIViewController+.swift
//  KazWeather
//
//  Created by 원태영 on 2/8/24.
//

import UIKit

extension UIViewController {
  func hideBackTitle() -> Self {
    self.navigationItem.backButtonTitle = ""
    return self
  }
  
  func navigationTitle(with title: String) -> Self {
    self.navigationItem.title = title
    return self
  }
}
