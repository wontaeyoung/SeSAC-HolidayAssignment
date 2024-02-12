//
//  MainViewController.swift
//  KazWeather
//
//  Created by 원태영 on 2/11/24.
//

import UIKit
import KazDesignSystem

final class MainViewController: BaseViewController, ViewModelController {
  
  // MARK: - UI
  private let mainView = MainView()
  
  
  // MARK: - Property
  let viewModel: MainViewModel
  
  
  // MARK: - Initializer
  init(viewModel: MainViewModel) {
    self.viewModel = viewModel
    
    super.init()
  }
  
  
  // MARK: - Life Cycle
  override func loadView() {
    self.view = mainView
  }
  
  override func bind() {
    viewModel.cityWeather.subscribe { cityWeather in
      self.mainView.updateCurrentWeatherUI(with: cityWeather)
    }
    
    viewModel.forecastBy3H.subscribe { forecastBy3H in
      self.mainView.updateForecastWeatherUI(with: forecastBy3H)
    }
  }
}
