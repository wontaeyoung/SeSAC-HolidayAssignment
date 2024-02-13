//
//  DefaultValueProvidable.swift
//  KazWeather
//
//  Created by 원태영 on 2/12/24.
//

protocol DefaultValueProvidable: Decodable {
  static var defaultValue: Self { get }
}

extension String: DefaultValueProvidable {
  static var defaultValue: String {
    return ""
  }
}

extension Double: DefaultValueProvidable {
  static var defaultValue: Double {
    return 0.0
  }
}

extension Float: DefaultValueProvidable {
  static var defaultValue: Float {
    return 0.0
  }
}

extension Bool: DefaultValueProvidable {
  static var defaultValue: Bool {
    return false
  }
}

extension Int: DefaultValueProvidable {
  static var defaultValue: Int {
    return 0
  }
}
