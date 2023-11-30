//
//  CreateProjectPresenter.swift
//  sampleCRUD
//
//  Created by syndromme on 24/10/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CreateProjectPresentationLogic
{
  func presentSuccessCreate(project: ProjectList.Project)
  func presentSuccessUpdate(project: ProjectList.Project)
  func presentSuccessDrafted(project: Project)
  func presentSuccessUpdateDraft(project: Project)
  func presentFailed(message: String)
}

class CreateProjectPresenter: CreateProjectPresentationLogic
{
  weak var viewController: CreateProjectDisplayLogic?
  
  func presentSuccessCreate(project: ProjectList.Project) {
    viewController?.displaySuccessCreate(project: project)
  }
  
  func presentSuccessUpdate(project: ProjectList.Project) {
    viewController?.displaySuccessUpdate(project: project)
  }
  
  func presentSuccessDrafted(project: Project) {
    viewController?.displaySuccessDrafted(project: project)
  }
  
  func presentSuccessUpdateDraft(project: Project) {
    viewController?.displaySuccessUpdateDraft(project: project)
  }
  
  func presentFailed(message: String) {
    viewController?.displayFailed(message: message)
  }
}
