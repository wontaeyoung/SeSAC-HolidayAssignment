import UIKit

public final class SecondaryLabel: UILabel {
  
  public init(text: String? = nil) {
    super.init(frame: .zero)
    
    configureView(text: text)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureView(text: String?) {
    self.text = text
    self.font = .systemFont(ofSize: 15, weight: .bold)
    self.textColor = .label
    self.textAlignment = .left
  }
}
