//
//  UIViewController+Extension.swift
//  sampleCRUD
//
//  Created by syndromme on 22/10/20.
//

import UIKit
import ActionSheetPicker_3_0

extension UIViewController {
  
  func showAlert(title: String, message: String, actions:[UIAlertAction] = []) {
    let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
    if actions.count == 0 {
      alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    } else {
    for action in actions {
      alertVC.addAction(action)
    }
    }
    present(alertVC, animated: true, completion: nil)
  }
  
  func showDatePicker(title: String, pickerMode: UIDatePicker.Mode, selectedDate: Date = Date(), minimumDate: Date = Date(), maximumDate: Date = Date(), action: Selector, cancel: Selector) {
    let datePicker = ActionSheetDatePicker(title: title, datePickerMode: pickerMode, selectedDate: selectedDate, minimumDate: minimumDate, maximumDate: maximumDate, target: self, action: action, cancelAction: cancel, origin: self.view)
    datePicker?.show()
  }
}
