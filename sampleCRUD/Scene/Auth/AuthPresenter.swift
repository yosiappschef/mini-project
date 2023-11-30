//
//  AuthPresenter.swift
//  sampleCRUD
//
//  Created by syndromme on 22/10/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AuthPresentationLogic
{
  func presentHomeScene()
  func presentLoginFailed(message: String)
}

class AuthPresenter: AuthPresentationLogic
{
  weak var viewController: AuthDisplayLogic?
  
  func presentHomeScene() {
    viewController?.displayHomeScene()
  }
  
  func presentLoginFailed(message: String) {
    viewController?.displayErrorMessage(message: message)
  }
}
