//
//  InputFieldView.swift
//  sampleCRUD
//
//  Created by syndromme on 22/10/20.
//

import UIKit

class InputFieldView: UIView {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var inputField: UITextField!
  @IBOutlet weak var errorLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    clearError()
  }
  
  func clearError() {
    errorLabel.text = ""
  }
}
