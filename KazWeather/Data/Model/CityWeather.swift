//
//  CityWeather.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

struct CityWeatherDTO: DTO {
  
  static let toCelsiusBuffer: Double = 273.15
  
  // MARK: - Property
  let id: Int              // 도시 ID
  let name: String         // 도시 이름
  let visibility: Int      // 가시거리
  let unixDate: Int        // 유닉스 타임
  let coord: CoordDTO      // 좌표
  let weather: WeatherDTO  // 날씨
  let wind: WindDTO        // 바람
  let main: MainDTO        // 온도, 기압, 습도 관련 정보
  let rain: RainDTO        // 강수
  let system: SystemDTO    // 일출, 일몰
  
  // MARK: - CodingKey
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case visibility
    case unixDate = "dt"
    case coord
    case weather
    case wind
    case main
    case rain
    case system = "sys"
  }
  
  // MARK: - Intializer
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id = try container.decodeWithDefaultValue(Int.self, forKey: .id)
    self.name = try container.decodeWithDefaultValue(String.self, forKey: .name)
    self.visibility = try container.decodeWithDefaultValue(Int.self, forKey: .visibility)
    self.unixDate = try container.decodeWithDefaultValue(Int.self, forKey: .unixDate)
    self.coord = try container.decode(CoordDTO.self, forKey: .coord)
    self.weather = try container.decode(WeatherDTO.self, forKey: .weather)
    self.wind = try container.decode(WindDTO.self, forKey: .wind)
    self.main = try container.decode(MainDTO.self, forKey: .main)
    self.rain = try container.decode(RainDTO.self, forKey: .rain)
    self.system = try container.decode(SystemDTO.self, forKey: .system)
  }
  
  init(id: Int, name: String, visibility: Int, unixDate: Int, coord: CoordDTO, weather: WeatherDTO, wind: WindDTO, main: MainDTO, rain: RainDTO, system: SystemDTO) {
    self.id = id
    self.name = name
    self.visibility = visibility
    self.unixDate = unixDate
    self.coord = coord
    self.weather = weather
    self.wind = wind
    self.main = main
    self.rain = rain
    self.system = system
  }
  
  // MARK: - Method
  func toEntity() -> CityWeather {
    return CityWeather(
      id: id,
      name: name,
      visibility: visibility,
      unixDate: unixDate,
      coord: coord.toEntity(),
      weather: weather.toEntity(),
      wind: wind.toEntity(),
      main: main.toEntity(),
      rain: rain.toEntity(),
      system: system.toEntity()
    )
  }
  
  
  static var defaultValue: CityWeatherDTO {
    return CityWeatherDTO(
      id: .defaultValue,
      name: .defaultValue,
      visibility: .defaultValue,
      unixDate: .defaultValue,
      coord: .defaultValue,
      weather: .defaultValue,
      wind: .defaultValue,
      main: .defaultValue,
      rain: .defaultValue,
      system: .defaultValue
    )
  }
}

struct CityWeather: Entity {
  
  let id: Int
  let name: String
  let visibility: Int
  let unixDate: Int
  let coord: Coord
  let weather: Weather
  let wind: Wind
  let main: Main
  let rain: Rain
  let system: System
  
  static var dummy: CityWeather {
    return CityWeather(
      id: 0, name: "Jeju City",
      visibility: 10000,
      unixDate: 1661871600,
      coord: Coord(lat: 0, lon: 0),
      weather: Weather(id: 0, weather: .Clouds, description: "Broken Clouds", icon: ""),
      wind: Wind(speed: 1, degree: 33, gust: 4),
      main: Main(temp: 5, feelsLike: 2, tempMin: -4, tempMax: 7, pressure: 1020, humidity: 73),
      rain: Rain(h1: 1, h3: 3),
      system: System(sunrise: 0, sunset: 0)
    )
  }
}

struct CoordDTO: DTO {
  
  // MARK: - Property
  let lat: Double
  let lon: Double
  
  // MARK: - CodingKey
  enum CodingKeys: String, CodingKey {
    case lat
    case lon
  }
  
  // MARK: - Intializer
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    lat = try container.decodeWithDefaultValue(Double.self, forKey: .lat)
    lon = try container.decodeWithDefaultValue(Double.self, forKey: .lon)
  }
  
  init(lat: Double, lon: Double) {
    self.lat = lat
    self.lon = lon
  }
  
  // MARK: - Method
  func toEntity() -> Coord {
    Coord(
      lat: lat,
      lon: lon
    )
  }
  
  static var defaultValue: CoordDTO {
    CoordDTO(
      lat: .defaultValue,
      lon: .defaultValue
    )
  }
}

struct Coord: Entity {
  
  let lat: Double
  let lon: Double
}

struct WeatherDTO: DTO {
  
  // MARK: - Property
  let id: Int
  let main: String
  let description: String
  let icon: String
  
  // MARK: - CodingKey
  enum CodingKeys: String, CodingKey {
    case id
    case main
    case description
    case icon
  }
  
  // MARK: - Intializer
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    id = try container.decodeWithDefaultValue(Int.self, forKey: .id)
    main = try container.decodeWithDefaultValue(String.self, forKey: .main)
    description = try container.decodeWithDefaultValue(String.self, forKey: .description)
    icon = try container.decodeWithDefaultValue(String.self, forKey: .icon)
  }
  
  init(
    id: Int,
    main: String,
    description: String,
    icon: String
  ) {
    self.id = id
    self.main = main
    self.description = description
    self.icon = icon
  }
  
  // MARK: - Method
  func toEntity() -> Weather {
    Weather(
      id: id,
      weather: Weather.WeatherCase(rawValue: main) ?? .unknown,
      description: description,
      icon: icon
    )
  }
  
  static var defaultValue: WeatherDTO {
    WeatherDTO(
      id: .defaultValue,
      main: .defaultValue,
      description: .defaultValue,
      icon: .defaultValue
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
  
  // MARK: - Property
  let speed: Double
  let degree: Int
  let gust: Double
  
  // MARK: - CodingKey
  enum CodingKeys: String, CodingKey {
    case speed
    case degree = "deg"
    case gust
  }
  
  // MARK: - Intializer
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    speed = try container.decodeWithDefaultValue(Double.self, forKey: .speed)
    degree = try container.decodeWithDefaultValue(Int.self, forKey: .degree)
    gust = try container.decodeWithDefaultValue(Double.self, forKey: .gust)
  }
  
  init(
    speed: Double,
    degree: Int,
    gust: Double
  ) {
    self.speed = speed
    self.degree = degree
    self.gust = gust
  }
  
  // MARK: - Method
  func toEntity() -> Wind {
    Wind(
      speed: Int(speed),
      degree: degree,
      gust: Int(gust)
    )
  }
  
  static var defaultValue: WindDTO {
    WindDTO(
      speed: .defaultValue,
      degree: .defaultValue,
      gust: .defaultValue
    )
  }
}

struct Wind: Entity {
  
  let speed: Int
  let degree: Int
  let gust: Int
}

struct MainDTO: DTO {
  
  // MARK: - Property
  let temp: Double
  let feelsLike: Double
  let tempMin: Double
  let tempMax: Double
  let pressure: Int
  let humidity: Int
  
  // MARK: - CodingKey
  enum CodingKeys: String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure
    case humidity
  }
  
  // MARK: - Intializer
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    temp = try container.decodeWithDefaultValue(Double.self, forKey: .temp)
    feelsLike = try container.decodeWithDefaultValue(Double.self, forKey: .feelsLike)
    tempMin = try container.decodeWithDefaultValue(Double.self, forKey: .tempMin)
    tempMax = try container.decodeWithDefaultValue(Double.self, forKey: .tempMax)
    pressure = try container.decodeWithDefaultValue(Int.self, forKey: .pressure)
    humidity = try container.decodeWithDefaultValue(Int.self, forKey: .humidity)
  }
  
  init(
    temp: Double,
    feelsLike: Double,
    tempMin: Double,
    tempMax: Double,
    pressure: Int,
    humidity: Int
  ) {
    self.temp = temp
    self.feelsLike = feelsLike
    self.tempMin = tempMin
    self.tempMax = tempMax
    self.pressure = pressure
    self.humidity = humidity
  }
  
  // MARK: - Method
  func toEntity() -> Main {
    Main(
      temp: Int(temp),
      feelsLike: Int(feelsLike),
      tempMin: Int(tempMin),
      tempMax: Int(tempMax),
      pressure: pressure,
      humidity: humidity
    )
  }
  
  static var defaultValue: MainDTO {
    MainDTO(
      temp: .defaultValue,
      feelsLike: .defaultValue,
      tempMin: .defaultValue,
      tempMax: .defaultValue,
      pressure: .defaultValue,
      humidity: .defaultValue
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
  
  // MARK: - Property
  let h1: Double
  let h3: Double
  
  // MARK: - CodingKey
  enum CodingKeys: String, CodingKey {
    case h1 = "1h"
    case h3 = "3h"
  }
  
  // MARK: - Intializer
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    h1 = try container.decodeWithDefaultValue(Double.self, forKey: .h1)
    h3 = try container.decodeWithDefaultValue(Double.self, forKey: .h3)
  }
  
  init(
    h1: Double,
    h3: Double
  ) {
    self.h1 = h1
    self.h3 = h3
  }
  
  // MARK: - Method
  func toEntity() -> Rain {
    Rain(
      h1: Int(h1),
      h3: Int(h3)
    )
  }
  
  static var defaultValue: RainDTO {
    RainDTO(
      h1: .defaultValue,
      h3: .defaultValue
    )
  }
}

struct Rain: Entity {
  
  let h1: Int
  let h3: Int
}

struct SystemDTO: DTO {
  
  // MARK: - Property
  let sunrise: Int
  let sunset: Int
  
  // MARK: - CodingKey
  enum CodingKeys: String, CodingKey {
    case sunrise
    case sunset
  }
  
  // MARK: - Initializer
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.sunrise = try container.decodeWithDefaultValue(Int.self, forKey: .sunrise)
    self.sunset = try container.decodeWithDefaultValue(Int.self, forKey: .sunset)
  }
  
  init(sunrise: Int, sunset: Int) {
    self.sunrise = sunrise
    self.sunset = sunset
  }
  
  // MARK: - Method
  func toEntity() -> System {
    return System(
      sunrise: sunrise,
      sunset: sunset
    )
  }
  
  static var defaultValue: SystemDTO {
    return SystemDTO(
      sunrise: .defaultValue,
      sunset: .defaultValue
    )
  }
}

struct System: Entity {
  
  let sunrise: Int
  let sunset: Int
}
