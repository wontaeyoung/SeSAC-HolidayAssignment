//
//  BaseTableViewCell.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
  
  class var identifier: String {
    return self.description()
  }
  
  func setHierarchy() { }
  func setAttribute() { }
  func setConstraint() { }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = .clear
    contentView.backgroundColor = .clear
    
    setHierarchy()
    setAttribute()
    setConstraint()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
