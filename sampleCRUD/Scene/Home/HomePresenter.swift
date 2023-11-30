//
//  HomePresenter.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 30/10/23.
//

import Foundation

protocol HomePresentationLogic {
    func presentHomeScene()
    func presentHomeFailed(message: String)
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    func presentHomeScene() {
        viewController?.displayHome()
    }
    
    func presentHomeFailed(message: String) {
        viewController?.showErrorMessage(error: message)
    }
    
    
}
