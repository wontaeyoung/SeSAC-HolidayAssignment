//
//  DailyForecastView.swift
//  KazWeather
//
//  Created by 원태영 on 2/13/24.
//

import UIKit
import KazDesignSystem
import SnapKit

final class DailyForecastView: BaseView {
  
  
  // MARK: - UI
  private let cardView = CardView()
  private let titleLabel = IconLabel(symbol: "calendar", text: "5일 간의 일기예보")
  private let divider = Divider()
  private let tableView = UITableView().configured {
    $0.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: DailyForecastTableViewCell.identifier)
    $0.backgroundColor = .clear
  }
  
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    addSubview(cardView)
    
    cardView.addSubviews(
      titleLabel,
      divider,
      tableView
    )
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
    
    tableView.snp.makeConstraints { make in
      make.top.equalTo(divider.snp.bottom).offset(8)
      make.horizontalEdges.equalToSuperview().inset(8)
      make.bottom.equalToSuperview()
    }
  }
  
  
  // MARK: - Method
  func setDelegate(with delegate: TableControllable) {
    self.tableView.delegate = delegate
    self.tableView.dataSource = delegate
  }
  
  func reloadData() {
    self.tableView.reloadData()
  }
}
