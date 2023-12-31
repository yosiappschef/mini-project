//
//  ProjectListPresenter.swift
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

protocol ProjectListPresentationLogic
{
  func presentProjects(projectResponse: ProjectList.ProjectResponse)
  func presentSuccessDelete()
}

class ProjectListPresenter: ProjectListPresentationLogic
{
  weak var viewController: ProjectListDisplayLogic?
  
  func presentProjects(projectResponse: ProjectList.ProjectResponse) {
    viewController?.displayProject(projectResponse: projectResponse)
  }
  
  func presentSuccessDelete() {
    viewController?.displaySuccessDelete()
  }
}
