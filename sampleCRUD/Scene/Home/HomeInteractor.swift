//
//  HomeInteractor.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 30/10/23.
//

import Foundation

protocol HomeBussinessLogic {
    func getDataHome()
}

protocol HomeDataStore {
    
}

class HomeInteractor: HomeBussinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: AuthWorker?
    func getDataHome() {
        // request data home
    }
    
    
}
