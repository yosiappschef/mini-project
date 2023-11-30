//
//  Constants.swift
//  sampleCRUD
//
//  Created by syndromme on 22/10/20.
//

import Foundation
import RxSwift

class Constant {
    public static let isDebug = true   // true - development / false - production
    
    public static let baseUrlDevelopment = "https://api.zohar.neo-fusion.com/"
    public static let baseUrlProduction = ""
    public static let baseUrl = isDebug ? baseUrlDevelopment : baseUrlProduction
    public static let baseUrlMovie = "https://api.themoviedb.org/3/"
    public static let apiKeyMovie = "261c0d84fb2c5c6bc37141ccbcd27c97"
    
    public static let clientID = "zohar-api-client"
    public static let clientSecret = "please-change-this"
    public static let apiKey = ""
    
    public static let errorKey: String = "errorKey"
    
    public static let paginateSize = 10
}

let disposeBag = DisposeBag()
