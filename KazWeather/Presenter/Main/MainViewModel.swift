//
//  MainViewModel.swift
//  KazWeather
//
//  Created by 원태영 on 2/11/24.
//

final class MainViewModel: ViewModel {
  
  
  // MARK: - Property
  weak var coordinator: MainCoordinator?
  let cityWeather: Bindable<CityWeather>
  let forecastBy3H: Bindable<[CityWeather]>
  
  let forecastBy3H3D: Bindable<[CityWeather]> = .init(value: [])
  let forecastBy5D: Bindable<[CityWeather]> = .init(value: [])
  
  
  // MARK: - Initializer
  init(coordinator: MainCoordinator? = nil, cityWeather: CityWeather, forecastBy3H: [CityWeather]) {
    self.coordinator = coordinator
    self.cityWeather = Bindable(value: cityWeather)
    self.forecastBy3H = Bindable(value: forecastBy3H)
    
    updateForecastBy3H3D()
    updateForecastBy5D()
  }
  
  
  // MARK: - Method
  func updateForecastBy3H3D() {
    let weatherCountFor3Days: Int = 24
    
    guard forecastBy3H.current.count > weatherCountFor3Days else {
      forecastBy3H3D.set(forecastBy3H.current)
      return
    }
    
    let processedData: [CityWeather] = forecastBy3H.current[..<weatherCountFor3Days].map { $0 }
    forecastBy3H3D.set(processedData)
  }
  
  func updateForecastBy5D() {
    let processedData = forecastBy3H.current.filter {
      return DateFormatManager.shared.isDate(with: $0.unixDate, by: .hour, equalTo: 12)
    }
    forecastBy5D.set(processedData)
  }
}
