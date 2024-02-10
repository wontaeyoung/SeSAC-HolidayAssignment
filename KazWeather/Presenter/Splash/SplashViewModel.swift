//
//  SplashViewModel.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

import Foundation

final class SplashViewModel: ViewModel {
  
  weak var coordinator: AppCoordinator?
  
  func request() {
    let lastCityID = User.default.cityID
    let requestID = lastCityID == 0 ? City.startCityID : lastCityID
    
    Task {
      let result = await HTTPClient.shared.callRequest(
        responseType: CityWeatherDTO.self,
        router: WeatherRouter.currentCity(id: requestID)
      )
      
      switch result {
        case .success(let cityWeather):
          await coordinator?.connectMainFlow(with: cityWeather)
          
        case .failure(let error):
          LogManager.shared.log(with: error, to: .network)
          await coordinator?.handle(error: error)
      }
    }
  }
}
