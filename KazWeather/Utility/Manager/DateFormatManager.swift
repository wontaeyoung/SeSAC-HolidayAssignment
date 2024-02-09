//
//  DateFormatManager.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

import Foundation

final class DateFormatManager {
  
  static let shared = DateFormatManager()
  private init() { }
  
  private let formatter = DateFormatter()
  
  func unixTimestampToString(with interval: TimeInterval, format: Format) -> String {
    let date = Date(timeIntervalSince1970: interval)
    formatter.dateFormat = Format.HHmm.format
    formatter.timeZone = .current
    
    return formatter.string(from: date)
  }
}

extension DateFormatManager {
  
  enum Format: String {
    case HHmm = "HH:mm"
    
    var format: String {
      return self.rawValue
    }
  }
}
