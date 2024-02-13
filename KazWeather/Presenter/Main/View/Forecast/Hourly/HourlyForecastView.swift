//
//  HourlyForecastView.swift
//  KazWeather
//
//  Created by 원태영 on 2/11/24.
//

import UIKit
import KazDesignSystem
import SnapKit

final class HourlyForecastView: BaseView {
  
  
  // MARK: - UI
  private let cardView = CardView()
  private let titleLabel = IconLabel(symbol: "calendar", text: "3시간 간격의 일기예보")
  private let divider = Divider()
  
  private let weatherScrollView = UIScrollView().configured {
    $0.showsHorizontalScrollIndicator = false
  }
  private let weatherStack = UIStackView().configured {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    $0.alignment = .fill
    $0.spacing = 10
  }
  
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    addSubview(cardView)
    
    cardView.addSubviews(
      titleLabel,
      divider,
      weatherScrollView
    )
    
    weatherScrollView.addSubview(weatherStack)
  }
  
  override func setConstraint() {
    cardView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.horizontalEdges.equalToSuperview().inset(8)
    }
    
    divider.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(8)
      make.horizontalEdges.equalToSuperview()
    }
    
    weatherScrollView.snp.makeConstraints { make in
      make.top.equalTo(divider.snp.bottom).offset(8)
      make.horizontalEdges.equalToSuperview()
      make.bottom.equalToSuperview().inset(8)
    }
    
    weatherStack.snp.makeConstraints { make in
      make.horizontalEdges.equalTo(weatherScrollView.contentLayoutGuide).inset(8)
      make.verticalEdges.equalTo(weatherScrollView.contentLayoutGuide)
      make.height.equalTo(weatherScrollView.frameLayoutGuide)
    }
  }
  
  
  // MARK: - Method
  func updateUI(with data: [CityWeather]) {
    clearWeatherStack()
    addWeatherInStack(with: data)
  }
  
  private func clearWeatherStack() {
    weatherStack.clear()
  }
  
  private func addWeatherInStack(with data: [CityWeather]) {
    data.forEach {
      weatherStack.addArrangedSubview(WeatherItemView(cityWeather: $0))
    }
  }
}
