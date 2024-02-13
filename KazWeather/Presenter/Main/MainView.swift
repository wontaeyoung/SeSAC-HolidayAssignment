//
//  MainView.swift
//  KazWeather
//
//  Created by 원태영 on 2/11/24.
//

import UIKit
import KazDesignSystem
import SnapKit

final class MainView: BaseView {
  
  
  // MARK: - UI
  private let backgroundImageView = UIImageView().configured {
    $0.image = .clouds
    $0.contentMode = .scaleAspectFill
  }
  private let scrollView = UIScrollView()
  private let paddingView = UIView().configured {
    $0.isUserInteractionEnabled = true
  }
  
  private let summaryView = WeatherSummaryView()
  private let hourlyForecastView = HourlyForecastView()
  
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    self.addSubviews(backgroundImageView, scrollView)
    self.scrollView.addSubview(paddingView)
    self.paddingView.addSubviews(summaryView, hourlyForecastView)
  }
  
  override func setAttribute() {
    
  }
  
  override func setConstraint() {
    backgroundImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    scrollView.snp.makeConstraints { make in
      make.edges.equalTo(self.safeAreaLayoutGuide)
    }
    
    paddingView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
    }
    
    summaryView.snp.makeConstraints { make in
      make.top.horizontalEdges.equalToSuperview()
    }
    
    hourlyForecastView.snp.makeConstraints { make in
      make.top.equalTo(summaryView.snp.bottom).offset(20)
      make.horizontalEdges.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
  
  // MARK: - Method
  func updateCurrentWeatherUI(with data: CityWeather) {
    self.summaryView.updateUI(with: data)
  }
  
  func updateForecastWeatherUI(with data: [CityWeather]) {
    self.hourlyForecastView.updateUI(with: data)
  }
}

#Preview {
  let controller = UINavigationController(
    rootViewController: MainViewController(
      viewModel: .init(cityWeather: .dummy, forecastBy3H: [CityWeather](repeating: .dummy, count: 20))
    )
  )
  controller.setNavigationBarHidden(true, animated: false)
  return controller
}
