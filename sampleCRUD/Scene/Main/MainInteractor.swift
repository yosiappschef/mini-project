//
//  MainInteractor.swift
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
import KeychainAccess

protocol MainBusinessLogic
{
  func getDepartmentList(page: Int, query: String, size: Int)
  func deleteDepartment()
  func setSelectedDepartment(department: Main.Department?)
  func logout()
}

protocol MainDataStore
{
  var selectedDepartment: Main.Department? { get set }
  var sorts: [String]? { get set }
}

class MainInteractor: MainBusinessLogic, MainDataStore
{
  var presenter: MainPresentationLogic?
  var worker: MainWorker?
  var selectedDepartment: Main.Department?
  var sorts: [String]?
  
  func getDepartmentList(page: Int = 1, query: String = "", size: Int = Constant.paginateSize) {
    worker = MainWorker()
    let request = Main.Request(page: page, size: size, q: query, sort: self.sorts)
    worker?.doDepartmentList(request: request).subscribe(onSuccess: { (results) in
      self.presenter?.presentDepartments(departmentResponse: results)
    }, onError: { (error) in
      
    }).disposed(by: disposeBag)
  }
  
  func deleteDepartment() {
    worker = MainWorker()
    worker?.doDeleteDepartment(id: "\(selectedDepartment?.id ?? 0)").subscribe(onCompleted: {
      self.getDepartmentList(page: 0)
      self.presenter?.presentSuccessDelete()
    }, onError: { (error) in
      
    }).disposed(by: disposeBag)
  }
  
  func setSelectedDepartment(department: Main.Department?) {
    selectedDepartment = department
  }
  
  func logout() {
    try! Keychain().remove("AccessToken")
  }
}
