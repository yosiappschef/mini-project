//
//  DraftListWorker.swift
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
import RxRealm
import RxSwift

class DraftListWorker
{
  let realm = try! Realm(configuration: Realm.Configuration(objectTypes: [Department.self, Project.self]))
  
//  func doObservable() -> Observable<[Department]> {
//    let objects = realm.objects(Department.self)
//    return Observable.array(from: objects).map { (results) -> [Department] in
//      return results
//    }
//  }
  
  func doObservable<T: Object>(ofType: T.Type) -> Observable<[T]> {
    let objects = realm.objects(T.self)
    return Observable.array(from: objects).map { (results) -> [T] in
      return results
    }
  }
  
  func doObservableChangeset<T: Object>(ofType: T.Type) -> Observable<([T], RealmChangeset?)> {
    let objects = realm.objects(T.self)
    return Observable.arrayWithChangeset(from: objects)
  }
  
  func doAddObject<T: Object>(object: T) {
    try! realm.write({
      realm.add(object)
    })
  }
  
  func doDeleteObject<T: Object>(object: T) {
    try! realm.write({
      realm.delete(object)
    })
  }
  
  func doUpdateObject<T: Object>(ofType: T.Type, oldObject: T, newObject: T) {
    try! realm.write({
      if ofType == Department.self {
        (oldObject as! Department).name = (newObject as! Department).name
        (oldObject as! Department).groupName = (newObject as! Department).groupName
        (oldObject as! Department).since = (newObject as! Department).since
        (oldObject as! Department).inTime = (newObject as! Department).inTime
        (oldObject as! Department).outTime = (newObject as! Department).outTime
      } else if ofType == Project.self {
        (oldObject as! Project).name = (newObject as! Project).name
        (oldObject as! Project).amount = (newObject as! Project).amount
        (oldObject as! Project).startDate = (newObject as! Project).startDate
        (oldObject as! Project).endDate = (newObject as! Project).endDate
      }
    })
  }
}
