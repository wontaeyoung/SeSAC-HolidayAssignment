//
//  WeatherItemView.swift
//  KazWeather
//
//  Created by 원태영 on 2/12/24.
//

import UIKit
import KazDesignSystem

final class WeatherItemView: UIStackView {
  
  
  // MARK: - UI
  private let timeLabel = SecondaryLabel().configured { $0.textAlignment = .center }
  private let weatherIconImageView = UIImageView().configured { $0.contentMode = .scaleAspectFit }
  private let temperatureLabel = SecondaryLabel().configured { $0.textAlignment = .center }
  
  init(cityWeather: CityWeather) {
    super.init(frame: .zero)
    
    configureStack()
    updateUI(with: cityWeather)
  }
  
  @available(*, unavailable)
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Method
  private func configureStack() {
    self.axis = .vertical
    self.distribution = .fillEqually
    self.alignment = .fill
    self.spacing = 20
    
    self.addArrangedSubviews(timeLabel, weatherIconImageView, temperatureLabel)
  }
  
  func updateUI(with data: CityWeather) {
    timeLabel.text = DateFormatManager.shared.unixTimestampToString(with: data.unixDate, format: .HHhour)
    weatherIconImageView.setImage(from: data.weather.profileURL, with: CGSize(width: 30, height: 30))
    temperatureLabel.text = data.main.temp.toTempString
  }
}
