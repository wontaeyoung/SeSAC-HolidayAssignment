//
//  City.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

import Foundation

struct CityDTO: DTO {
  
  let id: Int
  let name: String
  let state: String
  let country: String
  let coord: CoordDTO
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case state
    case country
    case coord
  }
  
  func toEntity() -> City {
    return City(
      id: id,
      name: name,
      state: state,
      country: country,
      coord: coord.toEntity()
    )
  }
  
  static var defaultValue: CityDTO {
    return CityDTO(
      id: .defaultValue,
      name: .defaultValue,
      state: .defaultValue,
      country: .defaultValue,
      coord: CoordDTO(lat: .defaultValue, lon: .defaultValue)
    )
  }
}

struct City: Entity {
  
  let id: Int
  let name: String
  let state: String
  let country: String
  let coord: Coord
  
  static let cityList: [City] = {
    guard let path = Bundle.main.path(forResource: "CityList", ofType: "json") else {
      return []
    }
    
    guard let data = try? String(contentsOfFile: path).data(using: .utf8) else {
      return []
    }
    
    guard let cityList = try? JsonCoder.shared.decode(to: [CityDTO].self, from: data) else {
      return []
    }
    
    return cityList.map { $0.toEntity() }
  }()
  
  static let startCityID: Int = 1835847
}
