//
//  NetworkTask.swift
//  sampleCRUD
//
//  Created by syndromme on 22/10/20.
//

import Moya

class NetworkTask {
  class func createParams(_ service: NetworkService) -> Task {
    switch service {
    case .Auth(let request):
      return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.httpBody)
    case .Department(let request):
      return .requestParameters(parameters: request.toJSON(), encoding: QueryArrayEncoding())
    case .CreateDepartment(let request), .UpdateDepartment(_, let request):
      return .requestData(request.toData())
    case .Project(let request):
      return .requestParameters(parameters: request.toJSON(), encoding: QueryArrayEncoding())
    case .CreateProject(let request), .UpdateProject(_, let request):
      return .requestData(request.toData())
    case .BannerMovie(let request):
        return .requestParameters(parameters: ["api_key" : Constant.apiKeyMovie, "page" : request.page], encoding: URLEncoding.queryString)
    default :
      return .requestPlain
    }
  }
}
