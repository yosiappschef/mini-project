//
//  AuthViewController.swift
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
import RxSwift
import RxCocoa

protocol AuthDisplayLogic: class
{
  func displayHomeScene()
  func displayErrorMessage(message: String)
}

class AuthViewController: UIViewController, AuthDisplayLogic
{
  var interactor: AuthBusinessLogic?
  var router: (NSObjectProtocol & AuthRoutingLogic & AuthDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = AuthInteractor()
    let presenter = AuthPresenter()
    let router = AuthRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var readButton: UIButton!
  @IBOutlet weak var writeButton: UIButton!
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  
  
  private final let grantype = "password"
  private final let username = "interview@neo-fusion.com"
  private final let password = "interview"
  
  private var scopes = [String]()
  private var isRead = false
  private var isWrite = false
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    if Constant.isDebug {
      emailField.text = username
      passwordField.text = password
    }
    setupButton()
  }
  
//  MARK: Setup
  func setupButton() {
    loginButton.rx.tap.bind { (_) in
      if self.validInput() {
        self.interactor?.login(grantType: self.grantype, scope: self.scopes.joined(separator: " "), username: self.emailField.text ?? "", password: self.passwordField.text ?? "")
      } else {
        self.showErrorModal(message: "Complete your input.")
      }
    }.disposed(by: disposeBag)
    
    readButton.rx.tap.bind { (_) in
      self.isRead = !self.isRead
      self.readButton.isSelected = self.isRead
      if self.scopes.contains("read") {
        self.scopes.removeAll{ $0 == "read" }
      } else {
        self.scopes.append("read")
      }
    }.disposed(by: disposeBag)
    
    writeButton.rx.tap.bind { (_) in
      self.isWrite = !self.isWrite
      self.writeButton.isSelected = self.isWrite
      if self.scopes.contains("write") {
        self.scopes.removeAll{ $0 == "write" }
      } else {
        self.scopes.append("write")
      }
    }.disposed(by: disposeBag)
  }
  
//  MARK: Display
  func displayHomeScene() {
    showSuccessLogin()
  }
  
  func displayErrorMessage(message: String) {
    showErrorModal(message: message)
  }
  
//  MARK: Custom
  func showSuccessLogin() {
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
//      self.router?.routeToMainScene()
      self.router?.routeToMenuScene()
    }
    showAlert(title: "Authentication", message: "You are logged in.", actions: [okAction])
  }
  
  func showErrorModal(message: String) {
    let okAction = UIAlertAction(title: "OK", style: .destructive)
    showAlert(title: "Authentication", message: message, actions: [okAction])
  }
  
  func validInput() -> Bool {
    if emailField.text!.isEmpty {
      return false
    }
    if passwordField.text!.isEmpty {
      return false
    }
    return true
  }
}
