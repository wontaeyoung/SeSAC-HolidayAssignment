//
//  ExtraInfoCollectionViewCell.swift
//  KazWeather
//
//  Created by 원태영 on 2/14/24.
//

import UIKit
import KazDesignSystem
import SnapKit

final class ExtraInfoCollectionViewCell: BaseCollectionViewCell {
  
  // MARK: - UI
  private let cardView = CardView()
  private let titleLabel = IconLabel(symbol: nil, text: nil)
  private let divider = Divider()
  private let contentLabel = PrimaryLabel()
  private let subContentLabel = TertiaryLabel()
  
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    contentView.addSubview(cardView)
    
    cardView.addSubviews(titleLabel, divider, contentLabel, subContentLabel)
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
    
    contentLabel.snp.makeConstraints { make in
      make.top.equalTo(divider.snp.bottom).offset(8)
      make.horizontalEdges.equalToSuperview().inset(8)
    }
    
    subContentLabel.snp.makeConstraints { make in
      make.horizontalEdges.bottom.equalToSuperview().inset(8)
    }
  }
  
  
  // MARK: - Method
  func updateUI(with data: CityWeather, info: ExtraInfo) {
    self.titleLabel.updateUI(symbol: info.iconSymbol, text: info.title)
    
    switch info {
      case .wind:
        self.contentLabel.text = "\(data.wind.speed)m/s"
        self.subContentLabel.text = "\(data.wind.gust)m/s"
        
      case .cloud:
        self.contentLabel.text = "\(data.cloud.all)%"
        
      case .pressure:
        self.contentLabel.text = "\(data.main.pressure)hpa"
        
      case .humidity:
        self.contentLabel.text = "\(data.main.humidity)%"
    }
  }
}
