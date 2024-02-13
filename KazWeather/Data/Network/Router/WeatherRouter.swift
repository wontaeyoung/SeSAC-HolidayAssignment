//
//  WeatherRouter.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

enum WeatherRouter: Router {
  
  case currentCity(id: Int)
  case currentCoord(lat: Double, long: Double)
  case forecast3hCity(id: Int)
  case forecast3hCoord(lat: Double, long: Double)
  case forecastDailyCity(id: Int)
  case forecastDailyCoord(lat: Double, long: Double)
  
  var method: HTTPMethod {
    return .get
  }
  
  var baseURL: String {
    return "https://api.openweathermap.org/data/2.5"
  }
  
  var path: String {
    switch self {
      case .currentCity, .currentCoord:
        return "/weather"
        
      case .forecast3hCity, .forecast3hCoord:
        return "/forecast"
        
      case .forecastDailyCity, .forecastDailyCoord:
        return "/forecast/daily"
    }
  }
  
  var headers: HTTPHeaders {
    return HTTPHeaders()
  }
  
  var parameters: HTTPParameters {
    let parameters = HTTPParameters()
      .parameter(key: Parameter.appid.key, value: APIKey.OpenWeather.authorization)
      .parameter(key: Parameter.lang.key, value: "kr")
    
    switch self {
      case let .currentCity(id):
        return parameters
          .parameter(key: Parameter.id.key, value: id)
        
      case let .currentCoord(lat, long):
        return parameters
          .parameter(key: Parameter.lat.key, value: lat)
          .parameter(key: Parameter.lon.key, value: long)
        
      case let .forecast3hCity(id):
        return parameters
          .parameter(key: Parameter.id.key, value: id)
          .parameter(key: Parameter.cnt.key, value: 12)
        
      case let .forecast3hCoord(lat, long):
        return parameters
          .parameter(key: Parameter.lat.key, value: lat)
          .parameter(key: Parameter.lon.key, value: long)
        
      case let .forecastDailyCity(id):
        return parameters
          .parameter(key: Parameter.id.key, value: id)
          .parameter(key: Parameter.cnt.key, value: 5)
        
      case let .forecastDailyCoord(lat, long):
        return parameters
          .parameter(key: Parameter.lat.key, value: lat)
          .parameter(key: Parameter.lon.key, value: long)
          .parameter(key: Parameter.cnt.key, value: 5)
    }
  }
}

extension WeatherRouter {
  
  enum Parameter: String {
    case appid
    case id
    case lat
    case lon
    case lang
    case cnt
    
    var key: String {
      return self.rawValue
    }
  }
}
