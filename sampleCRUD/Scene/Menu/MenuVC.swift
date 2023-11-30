//
//  MenuVC.swift
//  sampleCRUD
//
//  Created by syndromme on 24/10/20.
//

import UIKit
import KeychainAccess

class MenuVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  lazy var logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutAction(_:)))
  
  private final let menus = ["Department", "Project"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNav()
    setupTable()
  }

//  MARK: Setup
  func setupTable() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorInset = .zero
    tableView.tableFooterView = UIView()
  }
  
  func setupNav() {
    title = "MENU"
    navigationItem.leftBarButtonItems = [logoutButton]
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
//  MARK: Route
  func routeToDepartment() {
    let destinationVC = MainViewController(nibName: "MainView", bundle: nil)
    navigationController?.pushViewController(destinationVC, animated: true)
  }
  
  func routeToProject() {
    let destinationVC = ProjectListViewController(nibName: "ProjectListView", bundle: nil)
    navigationController?.pushViewController(destinationVC, animated: true)
  }
  
  func routeToAuthScene() {
    let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "authVC") as! AuthViewController
    destinationVC.modalTransitionStyle = .crossDissolve
    destinationVC.modalPresentationStyle = .overFullScreen
    present(destinationVC, animated: true, completion: nil)
  }
  
//  MARK: Action
  @IBAction func logoutAction(_ sender: Any) {
    doLogout()
  }
  
//  MARK: Custom
  func doLogout() {
    try! Keychain().remove("AccessToken")
    routeToAuthScene()
  }
}

extension MenuVC: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menus.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    cell.textLabel?.text = menus[indexPath.row]
    return cell
  }
}

extension MenuVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    switch indexPath.row {
    case 0:
      routeToDepartment()
      break
    case 1:
      routeToProject()
      break
    default:
      break
    }
  }
}
