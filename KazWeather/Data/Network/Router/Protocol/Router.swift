//
//  Router.swift
//  KazWeather
//
//  Created by 원태영 on 2/8/24.
//

import Foundation

protocol Router {
  
  var method: HTTPMethod { get }
  var baseURL: String { get }
  var path: String { get }
  var headers: HTTPHeaders { get }
  var parameters: HTTPParameters { get }
}

extension Router {
  
  func asURLRequest() throws -> URLRequest {
    guard var components = URLComponents(string: baseURL) else { throw HTTPError.invalidURL }
    components.path = path
    components.queryItems = parameters.current
    
    guard let url = components.url else { throw HTTPError.invalidURL }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.allHTTPHeaderFields = headers.current
    
    return request
  }
}
