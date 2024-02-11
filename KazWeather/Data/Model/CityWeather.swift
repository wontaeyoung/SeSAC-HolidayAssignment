//
//  CityWeather.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

struct CityWeatherDTO: DTO {
  
  static let toCelsiusBuffer: Double = 273.15
  
  let id: Int              // 도시 ID
  let name: String         // 도시 이름
  let coord: CoordDTO      // 좌표
  let weather: WeatherDTO  // 날씨
  let wind: WindDTO        // 바람
  let main: MainDTO        // 온도, 기압, 습도 관련 정보
  let rain: RainDTO        // 강수
  let system: SystemDTO    // 일출, 일몰
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case coord
    case weather
    case wind
    case main
    case rain
    case system = "sys"
  }
  
  func toEntity() -> CityWeather {
    return CityWeather(
      id: id,
      name: name,
      coord: coord.toEntity(),
      weather: weather.toEntity(),
      wind: wind.toEntity(),
      main: main.toEntity(),
      rain: rain.toEntity(),
      system: system.toEntity()
    )
  }
}

struct CityWeather: Entity {
  
  let id: Int
  let name: String
  let coord: Coord
  let weather: Weather
  let wind: Wind
  let main: Main
  let rain: Rain
  let system: System
  
  static var dummy: CityWeather {
    return CityWeather(
      id: 0, name: "Jeju City",
      coord: Coord(lat: 0, lon: 0),
      weather: Weather(id: 0, weather: .Clouds, description: "Broken Clouds", icon: ""),
      wind: Wind(speed: 1, degree: 33, gust: 4),
      main: Main(temp: 5, feelsLike: 2, tempMin: -4, tempMax: 7, pressure: 1020, humidity: 73),
      rain: Rain(h1: 0),
      system: System(sunrise: 0, sunset: 0)
    )
  }
}

struct CoordDTO: DTO, Encodable {
  
  let lat: Double
  let lon: Double
  
  enum CodingKeys: String, CodingKey {
    case lat
    case lon
  }
  
  func toEntity() -> Coord {
    return Coord(lat: lat, lon: lon)
  }
}

struct Coord: Entity {
  
  let lat: Double
  let lon: Double
}

struct WeatherDTO: DTO {
  
  let id: Int
  let main: String
  let description: String
  let icon: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case main
    case description
    case icon
  }
  
  func toEntity() -> Weather {
    return Weather(
      id: id,
      weather: .init(rawValue: main) ?? .unknown,
      description: description,
      icon: icon
    )
  }
}

struct Weather: Entity {
  
  let id: Int
  let weather: WeatherCase
  let description: String
  let icon: String
  
  enum WeatherCase: String {
    case Thunderstorm
    case Drizzle
    case Rain
    case Snow
    case Mist
    case Smoke
    case Haze
    case Dust
    case Fog
    case Sand
    case Ash
    case Squall
    case Tornado
    case Clear
    case Clouds
    case unknown
  }
}

struct WindDTO: DTO {
  
  let speed: Double // 풍속
  let degree: Int // 방향
  let gust: Double // 강풍속
  
  enum CodingKeys: String, CodingKey {
    case speed
    case degree = "deg"
    case gust
  }
  
  func toEntity() -> Wind {
    return Wind(
      speed: Int(speed),
      degree: degree,
      gust: Int(gust)
    )
  }
}

struct Wind: Entity {
  
  let speed: Int
  let degree: Int
  let gust: Int
}

struct MainDTO: DTO {
  
  let temp: Double // 현재 온도
  let feelsLike: Double // 체감 온도
  let tempMin: Double // 최저 온도
  let tempMax: Double // 최고 온도
  let pressure: Int // 기압
  let humidity: Int // 습도
  
  enum CodingKeys: String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure
    case humidity
  }
  
  func toEntity() -> Main {
    return Main(
      temp: Int(temp - CityWeatherDTO.toCelsiusBuffer),
      feelsLike: Int(feelsLike - CityWeatherDTO.toCelsiusBuffer),
      tempMin: Int(tempMin - CityWeatherDTO.toCelsiusBuffer),
      tempMax: Int(tempMax - CityWeatherDTO.toCelsiusBuffer),
      pressure: pressure,
      humidity: humidity
    )
  }
}

struct Main: Entity {
  
  let temp: Int
  let feelsLike: Int
  let tempMin: Int
  let tempMax: Int
  let pressure: Int
  let humidity: Int
}

struct RainDTO: DTO {
  let h1: Double
  
  enum CodingKeys: String, CodingKey {
    case h1 = "1h"
  }
  
  func toEntity() -> Rain {
    return Rain(h1: Int(h1))
  }
}

struct Rain: Entity {
  
  let h1: Int
}

struct SystemDTO: DTO {
  
  let sunrise: Int
  let sunset: Int
  
  enum CodingKeys: String, CodingKey {
    case sunrise
    case sunset
  }
  
  func toEntity() -> System {
    return System(
      sunrise: sunrise,
      sunset: sunset
    )
  }
}

struct System: Entity {
  
  let sunrise: Int
  let sunset: Int
}
