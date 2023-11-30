//
//  HomeTabController.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 28/11/23.
//

import Foundation
import UIKit

class HomeTabController: UITabBarController {
    
    override func viewDidLoad() {
        setupTabs()
        tabBar.backgroundColor = .white
//        self.setNavigationBar()
//        navigationController?.navigationBar.backgroundColor = .blue
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.additionalSafeAreaInsets.top = 80
//    }
    
    func setNavigationBar() {
//        let navbar = CustomNavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
//        self.view.addSubview(navbar)
        let navBar = CustomNavigationBar()
            navBar.translatesAutoresizingMaskIntoConstraints = false
            let navItem = UINavigationItem(title: "Home")
            let doneItem = UIBarButtonItem(image: UIImage(named: "Cancel"), style: .plain, target: self, action: nil)
            navItem.leftBarButtonItem = doneItem
            navBar.setItems([navItem], animated: false)
            self.view.addSubview(navBar)
//            if #available(iOS 11, *) {
//                let guide = view.safeAreaLayoutGuide
//                navBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
//            } else {
//                navBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
//            }
        navBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            navBar.heightAnchor.constraint(equalToConstant: 10).isActive = true
        }
    
//    override func viewDidLayoutSubviews() {
//        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
//        setNavigationBar()
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor.green
//                
//        // This will alter the navigation bar title appearance
//        let titleAttribute = [NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 25, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.purple] //alter to fit your needs
//        appearance.titleTextAttributes = titleAttribute
//
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
//        navigationController?.navigationItem.title = "Home"
//    }
    
    
    
    func setupTabs() {
        let home = self.createNav(with: "Home", and: UIImage(named: "splash_1") ?? UIImage(), vc: HomeAhaViewController())
        let post = self.createNav(with: "Post", and: UIImage(named: "post_image") ?? UIImage(), vc: PostViewController())
        viewControllers = [home, post]
    }
    
    func createNav(with title: String, and image: UIImage, vc: UIViewController) -> UINavigationController
    {
       let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "splash_1"), style: .plain, target: nil, action: nil)
        nav.viewControllers.first?.navigationItem.title = title
        nav.navigationBar.tintColor = .sandYellow
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = appearance
        return nav
    }
    
}
