//
//  BaseViewController.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

import UIKit

class BaseViewController: UIViewController {
  
  // MARK: - Property
  final var finishableKeyboardEditing: Bool
  
  
  // MARK: - Initializer
  init(finishableKeyboardEditing: Bool = false) {
    self.finishableKeyboardEditing = finishableKeyboardEditing
    
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Life Cycle
  func setHierarchy() { }
  func setAttribute() { }
  func setConstraint() { }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    view.backgroundColor = .weatherBackground
    
    setHierarchy()
    setAttribute()
    setConstraint()
    makeViewFinishableEditing()
  }
  
  
  // MARK: - Method
  final private func makeViewFinishableEditing() {
    let gesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
    gesture.cancelsTouchesInView = false
    view.addGestureRecognizer(gesture)
  }
  
  @objc final private func viewDidTap(_ sender: UIGestureRecognizer) {
    if finishableKeyboardEditing { view.endEditing(true) }
  }
}

