//
//  DraftListPresenter.swift
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
import RealmSwift

protocol DraftListPresentationLogic
{
  func presentObjects(objects: [Object])
  func presentSuccessDelete(objects: [Object])
  func presentSuccessUpdate(objects: [Object])
}

class DraftListPresenter: DraftListPresentationLogic
{
  weak var viewController: DraftListDisplayLogic?
  
  func presentObjects(objects: [Object]) {
    viewController?.displayObjects(objects: objects)
  }
  
  func presentSuccessDelete(objects: [Object]) {
    viewController?.displaySuccessDelete(objects: objects)
  }
  
  func presentSuccessUpdate(objects: [Object]) {
    viewController?.displaySuccessUpdate(objects: objects)
  }
}