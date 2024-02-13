//
//  Configurator+.swift
//  KazWeather
//
//  Created by 원태영 on 2/8/24.
//

import UIKit

protocol Configurator { }

extension Configurator where Self: Any {
  
  mutating func configure(_ apply: (inout Self) -> Void) {
    apply(&self)
  }
  
  func configured(_ apply: (inout Self) -> Void) -> Self {
    var configurableSelf = self
    apply(&configurableSelf)
    
    return configurableSelf
  }
}

extension Configurator where Self: AnyObject {
  
  func configure(_ apply: (Self) -> Void) {
    apply(self)
  }
  
  func configured(_ apply: (Self) -> Void) -> Self {
    apply(self)
    return self
  }
}

extension NSObject: Configurator { }
extension Array: Configurator { }
extension Dictionary: Configurator { }
extension Set: Configurator { }

extension UIButton.Configuration: Configurator { }
extension URLRequest: Configurator { }

extension HTTPHeader: Configurator { }
extension HTTPHeaders: Configurator { }
extension HTTPParameter: Configurator { }
extension HTTPParameters: Configurator { }

extension Calendar: Configurator { }
