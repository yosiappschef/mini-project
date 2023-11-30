//
//  ProjectListViewController.swift
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

protocol ProjectListDisplayLogic: class
{
  func displayProject(projectResponse: ProjectList.ProjectResponse)
  func displaySuccessDelete()
}

class ProjectListViewController: UIViewController, ProjectListDisplayLogic
{
  var interactor: ProjectListBusinessLogic?
  var router: (NSObjectProtocol & ProjectListRoutingLogic & ProjectListDataPassing)?

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
    let interactor = ProjectListInteractor()
    let presenter = ProjectListPresenter()
    let router = ProjectListRouter()
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
  
  @IBOutlet weak var tableView: UITableView!
  
  lazy var saveButton = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(newAction(_:)))
  lazy var draftsButton = UIBarButtonItem(title: "Drafts", style: .plain, target: self, action: #selector(draftsAction(_:)))
  lazy var sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortAction(_:)))
  
  private var resultSearchController: UISearchController = {
    let controller = UISearchController(searchResultsController: nil)
    controller.dimsBackgroundDuringPresentation = false
    controller.searchBar.sizeToFit()
    return controller
  }()
  
  private var response: ProjectList.ProjectResponse?
  var projects = [ProjectList.Project]()
  var workItem: DispatchWorkItem?
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    setupNav()
    setupTable()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    projects.removeAll()
    tableView.reloadData()
    interactor?.getProjectList(page: 0, name: "", size: Constant.paginateSize)
  }
  
//  MARK: Setup
  func setupTable() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorInset = .zero
    tableView.tableFooterView = UIView()
    
    resultSearchController.searchResultsUpdater = self
    tableView.tableHeaderView = resultSearchController.searchBar
  }
  
  func setupNav() {
    title = "PROJECTS"
//    navigationItem.leftBarButtonItems = [sortButton]
    navigationItem.rightBarButtonItems = [saveButton, draftsButton, sortButton]
  }
    
//  MARK: Display
  func displayProject(projectResponse: ProjectList.ProjectResponse) {
    self.response = projectResponse
    self.projects.append(contentsOf: projectResponse.content)
    tableView.reloadData()
  }
  
  func displaySuccessDelete() {
    showAlert(title: "Project", message: "Your project has been deleted.")
  }
    
//  MARK: Action
  @IBAction func newAction(_ sender: Any) {
    interactor?.setSelectedProject(project: nil)
    router?.routeToCreateProject()
  }
  
  @IBAction func draftsAction(_ sender: Any) {
    router?.routeToDraftListScene()
  }
  
  @IBAction func sortAction(_ sender: Any) {
    router?.routeToSorttListScene()
  }
    
//  MARK: Custom
  private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
    return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
      action.image?.withTintColor(.white)
      action.backgroundColor = .red
      let project = self.projects[indexPath.row]
      self.interactor?.setSelectedProject(project: project)
      self.interactor?.deleteProject()
      self.projects.removeAll()
      self.tableView.reloadData()
      self.resultSearchController.isActive = false
      completion(true)
    }
  }

  private func makeEditContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
    return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
      action.image?.withTintColor(.white)
      action.backgroundColor = .orange
      let project = self.projects[indexPath.row]
      self.interactor?.setSelectedProject(project: project)
      self.router?.routeToCreateProject()
      self.projects.removeAll()
      self.tableView.reloadData()
      self.resultSearchController.isActive = false
      completion(true)
    }
  }
}

extension ProjectListViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return projects.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    let project = projects[indexPath.row]
    cell.textLabel?.text = project.name
    cell.detailTextLabel?.text = "\(project.amount)"
    return cell
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    return UISwipeActionsConfiguration(actions: [makeDeleteContextualAction(forRowAt: indexPath),
                                                 makeEditContextualAction(forRowAt: indexPath)])
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == projects.count - 1 && response?.totalElements ?? 0 > projects.count {
      interactor?.getProjectList(page: projects.count/Constant.paginateSize, name: "", size: Constant.paginateSize)
    }
  }
}

extension ProjectListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension ProjectListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    workItem?.cancel()

    let workItem = DispatchWorkItem { [weak self] in
      self?.projects.removeAll()
      self?.interactor?.getProjectList(page: 0, name: searchController.searchBar.text ?? "", size: Constant.paginateSize)
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: workItem)
    self.workItem = workItem
  }
}
