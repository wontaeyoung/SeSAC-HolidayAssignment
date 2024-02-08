import UIKit

final class SecondaryButton: UIButton {
  
  private let action: () -> Void
  
  init(
    title: String? = nil,
    image: UIImage? = nil,
    titlePadding: CGFloat? = nil,
    imagePadding: CGFloat? = nil,
    action: @escaping () -> Void
  ) {
    self.action = action
    super.init(frame: .zero)
    
    configureView(title: title, image: image, titlePadding: titlePadding, imagePadding: imagePadding)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureView(
    title: String?,
    image: UIImage?,
    titlePadding: CGFloat?,
    imagePadding: CGFloat?
  ) {
    var config = UIButton.Configuration.tinted()
    config.buttonSize = .large
    config.cornerStyle = .medium
    config.title = title
    config.image = image
    
    if let titlePadding { config.titlePadding = titlePadding }
    if let imagePadding { config.imagePadding = imagePadding }
    
    self.configuration = config
    self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
  }
  
  @objc private func buttonTapped() {
    action()
  }
}
