//
//  SortListVC.swift
//  sampleCRUD
//
//  Created by syndromme on 23/10/20.
//

import UIKit

class SortListVC: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  lazy var doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction(_:)))
  
  private final let departmentSorts = ["name", "groupName", "since", "inTime", "outTime"]
  private final let projectSorts = ["name", "amount", "startDate", "endDate"]
  lazy var sorts: [String] = {
    switch sortType {
    case .Department:
      return departmentSorts
    case .Project:
      return projectSorts
    }
  }()
  private var selectedIndexes = [IndexPath]()
  var selectedSort = [String]()
  var sortType: DraftList.DraftType = .Department
  
  var doneTapped: (_ sender: [String]) -> Void = {_ in }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupData()
    setupNav()
    setupTable()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
//  MARK: Setup
  func setupData() {
    for sort in selectedSort {
      selectedIndexes.append(IndexPath(row: sorts.firstIndex{ $0 == sort } ?? 0, section: 0))
    }
  }
  
  func setupTable() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorInset = .zero
    tableView.tableFooterView = UIView()
  }
  
  func setupNav() {
    title = "SORT DEPARTMENT"
    navigationItem.rightBarButtonItems = [doneButton]
  }
  
//  MARK: Action
  @IBAction func doneAction(_ sender: Any) {
    var strings = [String]()
    for indexPath in selectedIndexes {
      strings.append(sorts[indexPath.row])
    }
    doneTapped(strings)
    dismiss(animated: true, completion: nil)
  }
}

extension SortListVC: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sorts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    let sort = sorts[indexPath.row]
    cell.textLabel?.text = sort
    cell.accessoryType = selectedIndexes.contains(indexPath) ? .checkmark : .none
    return cell
  }
}

extension SortListVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if selectedIndexes.contains(indexPath) {
      selectedIndexes.removeAll{ $0 == indexPath}
    } else {
      selectedIndexes.append(indexPath)
    }
    tableView.reloadRows(at: [indexPath], with: .automatic)
  }
}
