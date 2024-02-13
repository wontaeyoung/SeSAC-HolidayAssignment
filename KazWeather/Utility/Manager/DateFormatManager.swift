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
  private lazy var calendar = Calendar.current.configured { $0.locale = locale }
  
  func unixTimestampToString(with interval: TimeInterval, format: Format) -> String {
    formatter.dateFormat = format.format
    formatter.timeZone = .current
    
    return formatter.string(from: interval.date)
  }
  
  func isDate(with interval: TimeInterval, by component: Calendar.Component, equalTo: Int) -> Bool {
    return calendar.component(component, from: interval.date) == equalTo
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
