//
//  CreateDepartmentInteractor.swift
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

protocol CreateDepartmentBusinessLogic
{
  func createNewDepartment(name: String, groupName: String, inTime: String, outTime: String, since: String)
  func updateDepartment(id: String, name: String, groupName: String, inTime: String, outTime: String, since: String)
  func saveAsDraft(name: String?, groupName: String?, inTime: String?, outTime: String?, since: String?)
}

protocol CreateDepartmentDataStore
{
  var selectedDepartment: Main.Department? { get set }
  var draftDepartment: Department? { get set }
}

class CreateDepartmentInteractor: CreateDepartmentBusinessLogic, CreateDepartmentDataStore
{
  var presenter: CreateDepartmentPresentationLogic?
  var worker: CreateDepartmentWorker?
  var draftWorker: DraftListWorker?
  var selectedDepartment: Main.Department?
  var draftDepartment: Department?
  
  func createNewDepartment(name: String, groupName: String, inTime: String, outTime: String, since: String) {
    let request = CreateDepartment.Request(groupName: groupName, inTime: inTime, name: name, outTime: outTime, since: since)
    worker = CreateDepartmentWorker()
    draftWorker = DraftListWorker()
    worker?.doSaveDepartment(request: request).subscribe(onSuccess: { (result) in
      if self.draftDepartment != nil {
        self.draftWorker?.doDeleteObject(object: self.draftDepartment!)
      }
      self.presenter?.presentSuccessCreate(department: result)
    }, onError: { (error) in
      
    }).disposed(by: disposeBag)
  }
  
  func updateDepartment(id: String, name: String, groupName: String, inTime: String, outTime: String, since: String) {
    let request = CreateDepartment.Request(groupName: groupName, inTime: inTime, name: name, outTime: outTime, since: since)
    worker = CreateDepartmentWorker()
    worker?.doUpdateDepartment(id: id, request: request).subscribe(onSuccess: { (result) in
      self.presenter?.presentSuccessUpdate(department: result)
    }, onError: { (error) in
      
    }).disposed(by: disposeBag)
  }
  
  func saveAsDraft(name: String?, groupName: String?, inTime: String?, outTime: String?, since: String?) {
    draftWorker = DraftListWorker()
    let request = Department(name: name, groupName: groupName, since: since, inTime: inTime, outTime: outTime)
    draftWorker?.doObservableChangeset(ofType: Department.self).subscribe(onNext: { (departments, changes) in
      if changes?.inserted.count ?? 0 > 0 {
        self.presenter?.presentSuccessDrafted(department: request)
      }
      if changes?.updated.count ?? 0 > 0 {
        self.presenter?.presentSuccessUpdateDraft(department: request)
      }
    }).disposed(by: disposeBag)
    
    if draftDepartment == nil {
      draftWorker?.doAddObject(object: request)
    } else {
      draftWorker?.doUpdateObject(ofType: Department.self, oldObject: draftDepartment!, newObject: request)
    }
  }
}
