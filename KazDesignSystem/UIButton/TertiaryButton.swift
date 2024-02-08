import UIKit

final class TertiaryButton: UIButton {
  
  private let action: () -> Void
  
  init(
    title: String? = nil,
    titlePadding: CGFloat? = nil,
    action: @escaping () -> Void
  ) {
    self.action = action
    super.init(frame: .zero)
    
    configureView(title: title, titlePadding: titlePadding)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureView(
    title: String?,
    titlePadding: CGFloat?
  ) {
    var config = UIButton.Configuration.plain()
    config.buttonSize = .large
    config.cornerStyle = .medium
    config.title = title
    
    if let titlePadding { config.titlePadding = titlePadding }
    
    self.configuration = config
    self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
  }
  
  @objc private func buttonTapped() {
    action()
  }
}

