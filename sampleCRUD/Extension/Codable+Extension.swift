//
//  Codable+Extension.swift
//  sampleCRUD
//
//  Created by syndromme on 22/10/20.
//

import Foundation

extension Encodable {
  
  func toJSON() -> [String: Any] {
    let jsonEncoder = JSONEncoder()
    guard let jsonData = try? jsonEncoder.encode(self) else { return [:] }
    guard let json = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) else { return [:] }
    return json as? [String : Any] ?? [:]
  }
  
  func toData() -> Data {
    let jsonEncoder = JSONEncoder()
    guard let jsonData = try? jsonEncoder.encode(self) else { return Data() }
    return jsonData
  }
}
