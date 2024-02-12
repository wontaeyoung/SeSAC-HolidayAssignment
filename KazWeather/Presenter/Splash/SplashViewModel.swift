//
//  SplashViewModel.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

import Foundation

final class SplashViewModel: ViewModel {
  
  weak var coordinator: AppCoordinator?
  
  init(coordinator: AppCoordinator? = nil) {
    self.coordinator = coordinator
  }
  
  /// 두 케이스를 병렬 요청하게 되면서, 구조가 변경됨
  /// do-catch 구문에서 Result에 대해 try .get() 메서드로 성공과 에러 케이스에 대해 처리하는 것도 가능함
  /// Result에서는 HTTPError을 반환하지만, catch에서는 다시 Error 타입으로 업캐스팅 되어서 Result 타입을 사용하는 장점이 사라지는 것 같음
  /// HTTPClient의 callRequest를 throws 함수로 변경하고 응답 데이터를 반환하게 하는게 더 효율적일 듯
  /// Result 타입 사용을 유지하려면 어떻게 구현해야하지
  /// async let을 사용하니까 두 결과를 묶어서 switch를 돌리고 둘 다 성공했을 때만 화면 전환을 수행하면 될 듯
  func request() async {
    let lastCityID = User.default.cityID
    let requestID = lastCityID == 0 ? City.startCityID : lastCityID
    
    async let cityWeatherResult = HTTPClient.shared.callRequest(
      responseType: CityWeatherDTO.self,
      router: WeatherRouter.currentCity(id: requestID)
    )
    async let forecastBy3HResult = HTTPClient.shared.callRequest(
      responseType: ForecastBy3HResponseDTO.self,
      router: WeatherRouter.forecast3hCity(id: requestID)
    )
    
    let results = await (cityWeatherResult, forecastBy3HResult)
    
    switch results {
      case (.success(let cityWeather), .success(let forecastBy3H)):
        await coordinator?.connectMainFlow(currentWeather: cityWeather, forecastBy3H: forecastBy3H.list)
      
      case (.failure(let error), _), (_, .failure(let error)):
        LogManager.shared.log(with: error, to: .network)
        await coordinator?.handle(error: error)
    }
  }
}
