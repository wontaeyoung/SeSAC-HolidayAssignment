import UIKit

public final class IconLabel: BaseView {
  
  private let imageView = UIImageView()
  private let label = UILabel()
  
  public init(symbol: String?, text: String?) {
    self.imageView.image = UIImage(systemName: symbol ?? "")
    self.label.text = text
    
    super.init(frame: .zero)
  }
  
  public override func setHierarchy() {
    self.addSubview(imageView)
    self.addSubview(label)
  }
  
  public override func setAttribute() {
    self.backgroundColor = .clear
    imageView.contentMode = .scaleAspectFit
  }
  
  override public func setConstraint() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    label.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: self.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 22),
      imageView.heightAnchor.constraint(equalToConstant: 22)
    ])
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: self.topAnchor),
      label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
      label.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    ])
  }
}
