//
//  Date+Extension.swift
//  sampleCRUD
//
//  Created by syndromme on 22/10/20.
//

import Foundation

extension Date {
  func stringWithFormat(_ format: String, timezone: TimeZone) -> String? {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = format
      dateFormatter.timeZone = timezone
      dateFormatter.locale = Locale(identifier: "en_US_POSIX")
      return dateFormatter.string(from: self)
  }
}

extension String {
  func dateWithFormat(_ format: String, timezone: TimeZone) -> Date? {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = format
      dateFormatter.timeZone = timezone
      dateFormatter.locale = Locale(identifier: "en_US_POSIX")
      return dateFormatter.date(from: self)
  }
}
