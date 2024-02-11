//
//  PlaceholderLabel.swift
//  KazDesignSystem
//
//  Created by 원태영 on 2/8/24.
//

import UIKit

final public class PlaceholderLabel: UILabel {
  
  // MARK: - Property
  public var placeholder: String?
  private var isEmpty: Bool {
    return self.text?.isEmpty ?? true
  }
  
  private var tempText: String?
  override public var text: String? {
    didSet {
      updateTextVisibility()
    }
  }
  
  // MARK: - Initializer
  public init(placeholder: String?, font: UIFont = .systemFont(ofSize: UIFont.labelFontSize)) {
    self.placeholder = placeholder
    super.init(frame: .zero)
    
    configureView(font: font)
    updateTextVisibility()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Method
  private func configureView(font: UIFont) {
    self.font = font
    self.textAlignment = .left
  }
  
  private func updateTextVisibility() {
    guard let placeholder else { return }
    guard self.text != placeholder else { return }
    guard self.text != self.tempText else { return }
    
    self.textColor = isEmpty ? .secondaryLabel : .label
    self.tempText = self.text
    self.text = isEmpty ? placeholder : self.text
  }
}
