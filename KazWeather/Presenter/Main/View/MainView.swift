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
  private let dailyForecastView = DailyForecastView()
  private let extraInfoView = ExtraInfoView()
  
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    self.addSubviews(backgroundImageView, scrollView)
    self.scrollView.addSubview(paddingView)
    self.paddingView.addSubviews(summaryView, hourlyForecastView, dailyForecastView, extraInfoView)
  }
  
  override func setConstraint() {
    backgroundImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    scrollView.snp.makeConstraints { make in
      make.edges.equalTo(self.safeAreaLayoutGuide)
    }
    
    paddingView.snp.makeConstraints { make in
      make.edges.equalTo(scrollView.contentLayoutGuide)
      make.horizontalEdges.equalTo(self).inset(16)
      make.height.equalTo(1200)
    }
    
    summaryView.snp.makeConstraints { make in
      make.top.horizontalEdges.equalToSuperview()
    }
    
    hourlyForecastView.snp.makeConstraints { make in
      make.top.equalTo(summaryView.snp.bottom).offset(20)
      make.horizontalEdges.equalToSuperview()
    }
    
    /// 여기서 고정 높이를 주지 않으면 tableView Cell이 5개임에도 불구하고, 빈 셀로 채워지면서 가능한 전체 높이를 가져가버리는 이슈 있음
    dailyForecastView.snp.makeConstraints { make in
      make.top.equalTo(hourlyForecastView.snp.bottom).offset(20)
      make.horizontalEdges.equalToSuperview()
      make.height.equalTo(240)
    }
    
    extraInfoView.snp.makeConstraints { make in
      make.top.equalTo(dailyForecastView.snp.bottom).offset(20)
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
  
  func setDelegate(with delegate: TableControllable & CollectionControllable) {
    self.dailyForecastView.setDelegate(with: delegate)
    self.extraInfoView.setDelegate(with: delegate)
  }
  
  func reloadTableData() {
    self.dailyForecastView.reloadData()
  }
  
  func reloadCollectionData() {
    self.extraInfoView.reloadData()
  }
}
