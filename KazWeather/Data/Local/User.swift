//
//  User.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

final class User {
  
  static let `default` = User()
  
  private init() { }
  
  @UserDefault(key: .cityID, defaultValue: 0)
  var cityID: Int
}
