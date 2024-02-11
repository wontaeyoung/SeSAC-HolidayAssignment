//
//  WeatherSummaryView.swift
//  KazWeather
//
//  Created by 원태영 on 2/11/24.
//

import UIKit
import SnapKit
import KazDesignSystem

final class WeatherSummaryView: BaseView {
  
  
  // MARK: - UI
  private let cityNameLabel = PrimaryLabel().configured {
    $0.font = .systemFont(ofSize: 32, weight: .semibold)
    $0.textAlignment = .center
  }
  
  private let temperatureLabel = PrimaryLabel().configured {
    $0.font = .systemFont(ofSize: 80, weight: .semibold)
    $0.textAlignment = .center
  }
  
  private let weatherDescriptionLabel = SecondaryLabel().configured {
    $0.font = .systemFont(ofSize: 20, weight: .semibold)
    $0.textAlignment = .center
  }
  
  private let temperatureGapLabel = SecondaryLabel().configured {
    $0.font = .systemFont(ofSize: 20, weight: .semibold)
    $0.textAlignment = .center
  }
  
  private let feelLikeTemperatureLabel = SecondaryLabel().configured {
    $0.font = .systemFont(ofSize: 20, weight: .semibold)
    $0.textAlignment = .center
  }
  
  
  // MARK: - Initializer
  init(cityWeather: CityWeather) {
    super.init(frame: .zero)
    
    self.updateUI(with: cityWeather)
  }
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    addSubviews(
      cityNameLabel,
      temperatureLabel,
      weatherDescriptionLabel,
      temperatureGapLabel,
      feelLikeTemperatureLabel
    )
  }
  
  override func setAttribute() {
    self.backgroundColor = .clear
  }
  
  override func setConstraint() {
    cityNameLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(24)
      make.horizontalEdges.equalToSuperview()
    }
    
    temperatureLabel.snp.makeConstraints { make in
      make.top.equalTo(cityNameLabel.snp.bottom).offset(0)
      make.horizontalEdges.equalToSuperview()
    }
    
    weatherDescriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(temperatureLabel.snp.bottom).offset(0)
      make.horizontalEdges.equalToSuperview()
    }
    
    temperatureGapLabel.snp.makeConstraints { make in
      make.top.equalTo(weatherDescriptionLabel.snp.bottom).offset(6)
      make.horizontalEdges.equalToSuperview()
    }
    
    feelLikeTemperatureLabel.snp.makeConstraints { make in
      make.top.equalTo(temperatureGapLabel.snp.bottom).offset(6)
      make.horizontalEdges.bottom.equalToSuperview()
    }
  }
  
  // MARK: - Method
  func updateUI(with data: CityWeather) {
    self.cityNameLabel.text = data.name
    self.temperatureLabel.text = "\(data.main.temp)°"
    self.weatherDescriptionLabel.text = data.weather.description
    self.temperatureGapLabel.text = "최고 : \(data.main.tempMax)° | 최저 : \(data.main.tempMin)°"
    self.feelLikeTemperatureLabel.text = "체감온도 \(data.main.feelsLike)°"
  }
}

#Preview {
  let controller = UINavigationController(
    rootViewController: MainViewController(viewModel: .init(cityWeather: .dummy), cityWeather: .dummy)
  )
  controller.setNavigationBarHidden(true, animated: false)
  return controller
}
