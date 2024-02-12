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
  
  /// URL 생성 실패 오류 발생
  /// baseURL에 도메인 + 공통 path까지 포함시켜놓았기 때문
  /// URLComponents는 도메인 주소 이후에 오는 /부터는 path로 간주하기 때문에, 덮어쓰기를 되어버림
  /// 문제를 해결하면 Components 초기화 시 baseURL과 path를 합친 상태로 주입해야 함
  func asURLRequest() throws -> URLRequest {
    guard var components = URLComponents(string: baseURL + path) else { throw HTTPError.invalidURL }
    components.queryItems = parameters.current
    
    guard let url = components.url else { throw HTTPError.invalidURL }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.allHTTPHeaderFields = headers.current
    
    return request
  }
}
