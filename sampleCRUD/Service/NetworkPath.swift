//
//  NetworkPath.swift
//  sampleCRUD
//
//  Created by syndromme on 22/10/20.
//

import Foundation

class NetworkPath {
  class func createPath(_ service: NetworkService) -> String {
    switch service {
    case .Auth:
      return "oauth/token"
    case .Department, .CreateDepartment:
      return "demo/department"
    case .UpdateDepartment(let id, _), .DeleteDepartment(let id):
      return "demo/department/\(id)"
    case .Project, .CreateProject:
      return "demo/project"
    case .UpdateProject(let id, _), .DeleteProject(let id):
      return "demo/project/\(id)"
    case .BannerMovie:
        return "movie/now_playing"
    }
  }
}
