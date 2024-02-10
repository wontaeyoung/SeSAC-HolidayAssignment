import UIKit

final public class PrimaryLabel: UILabel {
  
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
    self.font = .systemFont(ofSize: 17, weight: .black)
    self.textColor = .label
    self.textAlignment = .left
  }
}
