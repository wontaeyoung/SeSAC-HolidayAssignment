//
//  DailyForecastTableViewCell.swift
//  KazWeather
//
//  Created by 원태영 on 2/13/24.
//

import UIKit
import KazDesignSystem
import SnapKit

final class DailyForecastTableViewCell: BaseTableViewCell {
  
  // MARK: - UI
  private let weekNameLabel = SecondaryLabel()
  private let weatherIconImageView = UIImageView().configured { $0.contentMode = .scaleAspectFit }
  private let temperatureGapLabel = SecondaryLabel()
  
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    contentView.addSubviews(weekNameLabel, weatherIconImageView, temperatureGapLabel)
  }
  
  override func setConstraint() {
    weekNameLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.verticalEdges.equalToSuperview().inset(8)
      make.width.equalToSuperview().multipliedBy(0.2)
      make.height.equalTo(22)
    }
    
    weatherIconImageView.snp.makeConstraints { make in
      make.leading.equalTo(weekNameLabel.snp.trailing).offset(8)
      make.size.centerY.equalTo(weekNameLabel)
    }
    
    temperatureGapLabel.snp.makeConstraints { make in
      make.leading.equalTo(weatherIconImageView.snp.trailing).offset(8)
      make.trailing.equalToSuperview()
      make.size.centerY.equalTo(weekNameLabel)
    }
  }
  
  
  // MARK: - Method
  func updateUI(with data: CityWeather, row: Int) {
    self.weekNameLabel.text = row == 0 ? "오늘" : DateFormatManager.shared.unixTimestampToString(with: data.unixDate, format: .EEEE)
    self.weatherIconImageView.setImage(from: data.weather.iconURL, with: CGSize(width: 22, height: 22))
    self.temperatureGapLabel.text = "\(data.main.tempMin.toTempString) / \(data.main.tempMax.toTempString)"
  }
}

