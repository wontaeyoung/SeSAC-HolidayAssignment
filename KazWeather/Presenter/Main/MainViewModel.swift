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
  
  
  // MARK: - Initializer
  init(coordinator: MainCoordinator? = nil, cityWeather: CityWeather, forecastBy3H: [CityWeather]) {
    self.coordinator = coordinator
    self.cityWeather = Bindable(value: cityWeather)
    self.forecastBy3H = Bindable(value: forecastBy3H)
  }
}
