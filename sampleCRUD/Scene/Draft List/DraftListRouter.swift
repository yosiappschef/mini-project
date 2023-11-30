//
//  DraftListRouter.swift
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

@objc protocol DraftListRoutingLogic
{
  func routeToCreateDepartment()
  func routeToCreateProject()
}

protocol DraftListDataPassing
{
  var dataStore: DraftListDataStore? { get }
}

class DraftListRouter: NSObject, DraftListRoutingLogic, DraftListDataPassing
{
  weak var viewController: DraftListViewController?
  var dataStore: DraftListDataStore?
  
  // MARK: Routing
  func routeToCreateDepartment() {
    let destinationVC = CreateDepartmentViewController(nibName: "CreateDepartmentView", bundle: nil)
    var destinationDS = destinationVC.router!.dataStore!
    passDataToCreateDepartment(source: dataStore!, destination: &destinationDS)
    navigateToCreateDepartment(source: viewController!, destination: destinationVC)
  }
  
  func routeToCreateProject() {
    let destinationVC = CreateProjectViewController(nibName: "CreateProjectView", bundle: nil)
    var destinationDS = destinationVC.router!.dataStore!
    passDataToCreateProject(source: dataStore!, destination: &destinationDS)
    navigateToCreateProject(source: viewController!, destination: destinationVC)
  }
  
  // MARK: Navigation
  func navigateToCreateDepartment(source: DraftListViewController, destination: CreateDepartmentViewController)
  {
    source.navigationController?.pushViewController(destination, animated: true)
  }
  
  func navigateToCreateProject(source: DraftListViewController, destination: CreateProjectViewController)
  {
    source.navigationController?.pushViewController(destination, animated: true)
  }
  
  // MARK: Passing data
  func passDataToCreateDepartment(source: DraftListDataStore, destination: inout CreateDepartmentDataStore)
  {
    destination.selectedDepartment = source.selectedDepartment
    destination.draftDepartment = source.draftDepartment
  }
  
  func passDataToCreateProject(source: DraftListDataStore, destination: inout CreateProjectDataStore)
  {
    destination.selectedProject = source.selectedProject
    destination.draftProject = source.draftProject
  }
  
}
