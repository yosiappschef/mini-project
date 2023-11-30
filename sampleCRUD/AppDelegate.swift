//
//  AppDelegate.swift
//  sampleCRUD
//
//  Created by syndromme on 22/10/20.
//

import UIKit
import KeychainAccess

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    let token = try! Keychain().getString("AccessToken")
    
    let mainVC = MenuVC(nibName: "MenuView", bundle: nil)//MainViewController(nibName: "MainView", bundle: nil)
    let authVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "authVC") as! AuthViewController
      
    let HomeVC = UIStoryboard(name: "HomeView", bundle: nil).instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
      
      let splashVC = SplashScreenViewController()
    let nav = UINavigationController(rootViewController: token == nil || token!.isEmpty ? splashVC : mainVC)
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = nav
    window?.makeKeyAndVisible()
    
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

