//
//  CreateProjectViewController.swift
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

protocol CreateProjectDisplayLogic: class
{
  func displaySuccessCreate(project: ProjectList.Project)
  func displaySuccessUpdate(project: ProjectList.Project)
  func displaySuccessDrafted(project: Project)
  func displaySuccessUpdateDraft(project: Project)
  func displayFailed(message: String)
}

class CreateProjectViewController: UIViewController, CreateProjectDisplayLogic
{
  var interactor: CreateProjectBusinessLogic?
  var router: (NSObjectProtocol & CreateProjectRoutingLogic & CreateProjectDataPassing)?

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
    let interactor = CreateProjectInteractor()
    let presenter = CreateProjectPresenter()
    let router = CreateProjectRouter()
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
  @IBOutlet weak var mainStack: UIStackView!
  
  lazy var nameInput: InputFieldView = {
    let v = InputFieldView.nib(withType: InputFieldView.self)
    v.titleLabel.text = "Name"
    return v
  }()
  lazy var amountInput: InputFieldView = {
    let v = InputFieldView.nib(withType: InputFieldView.self)
    v.titleLabel.text = "Amount"
    v.inputField.keyboardType = .numberPad
    return v
  }()
  lazy var startDateInput: InputFieldView = {
    let v = InputFieldView.nib(withType: InputFieldView.self)
    v.titleLabel.text = "Start Date"
    v.inputField.tag = 3
    v.inputField.delegate = self
    return v
  }()
  lazy var endDateInput: InputFieldView = {
    let v = InputFieldView.nib(withType: InputFieldView.self)
    v.titleLabel.text = "End Date"
    v.inputField.tag = 4
    v.inputField.delegate = self
    return v
  }()
  
  lazy var saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveAction(_:)))
  lazy var draftButton = UIBarButtonItem(title: "Draft", style: .plain, target: self, action: #selector(draftAction(_:)))
  
  private var startDate: Date?
  private var endDate: Date?
  private var dateSelection: CreateProject.DateSelection?
  
  private final var selectedProject: ProjectList.Project? {
    return self.router?.dataStore?.selectedProject
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    setupNav()
    setupLayout()
    setupSelectedProject()
  }
  
//  MARK: Setup
  func setupLayout() {
    mainStack.addArrangedSubview(nameInput)
    mainStack.addArrangedSubview(amountInput)
    mainStack.addArrangedSubview(startDateInput)
    mainStack.addArrangedSubview(endDateInput)
  }
  
  func setupNav() {
    title = "CREATE PROJECT"
    navigationItem.rightBarButtonItems = [saveButton, draftButton]
  }
  
  func setupSelectedProject() {
    if selectedProject != nil {
      nameInput.inputField.text = selectedProject?.name
      amountInput.inputField.text = "\(selectedProject?.amount ?? 0)"
      startDate = selectedProject?.startDate?.dateWithFormat("YYYY-MM-dd", timezone: .current)
      endDate = selectedProject?.endDate?.dateWithFormat("YYYY-MM-dd", timezone: .current)
      startDateInput.inputField.text = startDate?.stringWithFormat("dd MMM YYYY", timezone: TimeZone.current)
      endDateInput.inputField.text = endDate?.stringWithFormat("dd MMM YYYY", timezone: TimeZone.current)
    }
  }
  
//  MARK: Display
  func displaySuccessCreate(project: ProjectList.Project) {
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
      self.navigationController?.popViewController(animated: true)
    }
    showAlert(title: "Project", message: "Your \(project.name) has been created.", actions: [okAction])
  }
  
  func displaySuccessUpdate(project: ProjectList.Project) {
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
      self.navigationController?.popViewController(animated: true)
    }
    showAlert(title: "Project", message: "Your \(project.name) has been updated.", actions: [okAction])
  }
  
  func displaySuccessDrafted(project: Project) {
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
      self.navigationController?.popViewController(animated: true)
    }
    showAlert(title: "Project", message: "Your \(project.name ?? "") has been drafted.", actions: [okAction])
  }
  
  func displaySuccessUpdateDraft(project: Project) {
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
      self.navigationController?.popViewController(animated: true)
    }
    showAlert(title: "Project", message: "Your \(project.name ?? "") has been updated.", actions: [okAction])
  }
  
  func displayFailed(message: String) {
    showAlert(title: "Project Failed", message: message)
  }
  
//  MARK: Action
  @IBAction func saveAction(_ sender: Any) {
    if validInput() {
      if selectedProject == nil || router?.dataStore?.draftProject != nil {
        interactor?.createNewProject(name: nameInput.inputField.text ?? "",
                                     amount: Int(amountInput.inputField.text ?? "0") ?? 0,
                                     startDate: startDate?.stringWithFormat("YYYY-MM-dd", timezone: .current) ?? "",
                                     endDate: endDate?.stringWithFormat("YYYY-MM-dd", timezone: .current) ?? "")
      } else {
        interactor?.updateProject(id: "\(selectedProject?.id ?? 0)",
                                  name: nameInput.inputField.text ?? "",
                                  amount: Int(amountInput.inputField.text ?? "0") ?? 0,
                                  startDate: startDate?.stringWithFormat("YYYY-MM-dd", timezone: .current) ?? "",
                                  endDate: endDate?.stringWithFormat("YYYY-MM-dd", timezone: .current) ?? "")
      }
    }
  }
  
  @IBAction func draftAction(_ sender: Any) {
    interactor?.saveAsDraft(name: nameInput.inputField.text ?? "",
                            amount: amountInput.inputField.text ?? "",
                            startDate: startDate?.stringWithFormat("YYYY-MM-dd", timezone: .current) ?? "",
                            endDate: endDate?.stringWithFormat("YYYY-MM-dd", timezone: .current) ?? "")
  }
  
  @IBAction func doneDatePicker(_ sender: Any) {
    let date = sender as? Date ?? Date()
    switch dateSelection {
    case .StartDate:
      startDate = date
      startDateInput.inputField.text = date.stringWithFormat("dd MMM YYYY", timezone: TimeZone.current)
      startDateInput.inputField.endEditing(true)
      break
    case .EndDate:
      endDate = date
      endDateInput.inputField.text = date.stringWithFormat("dd MMM YYYY", timezone: TimeZone.current)
      endDateInput.inputField.endEditing(true)
      break
    default:
      break
    }
    
  }
  
  @IBAction func cancelDatePicker(_ sender: Any) {
    
  }
  
//  MARK: Custom
  func validInput() -> Bool {
    nameInput.clearError()
    amountInput.clearError()
    startDateInput.clearError()
    endDateInput.clearError()
    
    if nameInput.inputField.text!.isEmpty {
      nameInput.errorLabel.text = "This field is required!"
      return false
    }
    if amountInput.inputField.text!.isEmpty {
      amountInput.errorLabel.text = "This field is required!"
      return false
    }
    if startDateInput.inputField.text!.isEmpty {
      startDateInput.errorLabel.text = "This field is required!"
      return false
    }
    if endDateInput.inputField.text!.isEmpty {
      endDateInput.errorLabel.text = "This field is required!"
      return false
    }
    
    return true
  }
}

extension CreateProjectViewController: UITextFieldDelegate {
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    var title = ""
    var selectedDate: Date?
    switch textField.tag {
    case 3:
      title = "Start Date"
      selectedDate = startDate
      dateSelection = .StartDate
      break
    case 4:
      title = "End Date"
      selectedDate = endDate
      dateSelection = .EndDate
      break
    default:
      break
    }
    showDatePicker(title: title,
                   pickerMode: .date,
                   selectedDate: selectedDate ?? Date(),
                   minimumDate: Calendar.current.date(byAdding: .year, value: -100, to: Date()) ?? Date(),
                   maximumDate: Calendar.current.date(byAdding: .year, value: 100, to: Date()) ?? Date(),
                   action: #selector(doneDatePicker(_:)),
                   cancel: #selector(cancelDatePicker(_:)))
    return false
  }
}
