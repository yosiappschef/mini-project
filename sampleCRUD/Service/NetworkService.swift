//
//  NetworkService.swift
//  sampleCRUD
//
//  Created by syndromme on 22/10/20.
//

import Moya
import KeychainAccess

let Provider = MoyaProvider<NetworkService>(plugins: [NetworkLoggerPlugin()])

enum AppError: Swift.Error, LocalizedError {
  case genericError(message: String)
  case serverError
  case dataNotFound

  public var errorDescription: String? {
    get {
      switch self {
      case .serverError:
        return "ServerError"
      case .genericError(let message):
        return message
      case .dataNotFound:
        return "Data Not Found"
      }
    }
  }
}

enum NetworkService {
  case Auth(params: Auth.Request)
  case Department(params: Main.Request)
  case CreateDepartment(params: CreateDepartment.Request)
  case UpdateDepartment(id: String, params: CreateDepartment.Request)
  case DeleteDepartment(id: String)
  case Project(params: ProjectList.Request)
  case CreateProject(params: CreateProject.Request)
  case UpdateProject(id: String, params: CreateProject.Request)
  case DeleteProject(id: String)
    // movie db
    case BannerMovie(params: Banner.Request)
}

extension NetworkService: TargetType {
  
  public var baseURL: URL {
    return URL(string: Constant.baseUrlMovie)!
  }
  
  public var path: String {
    return NetworkPath.createPath(self)
  }
  
  public var method: Moya.Method {
    switch self {
    case .Department, .Project, .BannerMovie:
      return .get
    case .UpdateDepartment, .UpdateProject:
      return .put
    case .DeleteDepartment, .DeleteProject:
      return .delete
    default:
      return .post
    }
  }
  
  public var sampleData: Data {
    return Data()
  }
  
  public var task: Task {
    return NetworkTask.createParams(self)
  }
  
  public var headers: [String : String]? {
    switch self {
    case .Auth:
      return ["Accept" : "application/json",
              "Content-Type" : "application/x-www-form-urlencoded",
              "Authorization" : "Basic em9oYXItYXBpLWNsaWVudDpwbGVhc2UtY2hhbmdlLXRoaXM="]
    default:
        return [
          "accept": "application/json",
        ]
//      let type = try! Keychain().getString("TokenType")
//      let accessToken = try! Keychain().getString("AccessToken")
//      return ["Accept" : "application/json",
//              "Content-Type" : "application/json",
//              "Authorization" : "\(type?.capitalized ?? "") \(accessToken ?? "")"]
    }
  }
}


class HandlingResponsePlugin: PluginType {
  func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
    if let statusCode = try? result.get().statusCode {
      if statusCode != 200 {
        let errorDict = [Constant.errorKey : try! result.get().mapJSON()]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "error"), object: nil, userInfo: errorDict as [AnyHashable : Any])
      }
      print("#statusCode \(statusCode)")
    }
    return result
  }
}
