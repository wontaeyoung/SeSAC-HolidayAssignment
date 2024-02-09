//
//  WeatherRouter.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

enum WeatherRouter: Router {
  
  case currentCity(id: Int)
  case currentCoord(lat: Double, long: Double)
  case forecastCity(id: Int)
  case forecastCoord(lat: Double, long: Double)
  
  var method: HTTPMethod {
    return .get
  }
  
  var baseURL: String {
    return "https://api.openweathermap.org/data/2.5"
  }
  
  var path: String {
    switch self {
      case .currentCity, .currentCoord:
        return "/current"
        
      case .forecastCity, .forecastCoord:
        return "/forecast"
    }
  }
  
  var headers: HTTPHeaders {
    return HTTPHeaders()
  }
  
  var parameters: HTTPParameters {
    var parameters = HTTPParameters().parameter(key: Parameter.appid.key, value: APIKey.openWeather)
    
    switch self {
      case let .currentCity(id):
        return parameters
          .parameter(key: Parameter.id.key, value: id.description)
        
      case let .currentCoord(lat, long):
        return parameters
          .parameter(key: Parameter.lat.key, value: lat.description)
          .parameter(key: Parameter.lon.key, value: long.description)
        
      case let .forecastCity(id):
        return parameters
          .parameter(key: Parameter.id.key, value: id.description)
        
      case let .forecastCoord(lat, long):
        return parameters
          .parameter(key: Parameter.lat.key, value: lat.description)
          .parameter(key: Parameter.lon.key, value: long.description)
    }
  }
}

extension WeatherRouter {
  
  enum Parameter: String {
    case appid
    case id
    case lat
    case lon
    
    var key: String {
      return self.rawValue
    }
  }
}
