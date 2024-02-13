//
//  TimeInterval+.swift
//  KazWeather
//
//  Created by 원태영 on 2/14/24.
//

import Foundation

extension TimeInterval {
  var date: Date {
    return Date(timeIntervalSince1970: self)
  }
}
