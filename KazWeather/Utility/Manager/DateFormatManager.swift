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
  
  private let locale = Locale(identifier: "ko_KR")
  private lazy var formatter = DateFormatter().configured { $0.locale = locale }
  
  func unixTimestampToString(with interval: TimeInterval, format: Format) -> String {
    formatter.dateFormat = format.format
    formatter.timeZone = .current
    
    return formatter.string(from: interval.date)
  }
}

extension DateFormatManager {
  
  enum Format: String {
    case HHmm = "HH:mm"
    case HHhour = "HH시"
    case EEEE = "EEEE"
    
    var format: String {
      return self.rawValue
    }
  }
}
