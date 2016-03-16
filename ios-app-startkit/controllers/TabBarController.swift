//
//  TabBarController.swift
//  ios-app-startkit
//
//  Created by Boom.Lee on 3/15/16.
//  Copyright © 2016 Boom.Lee. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initControllers()
  }
  
  func initControllers() {
    let home = HomeController()
    let personal = PersonalController()
    let webview = WebViewController()
    
    let homeNav = UINavigationController(rootViewController: home)
    let personalNav = UINavigationController(rootViewController: personal)
    let webviewNav = UINavigationController(rootViewController: webview)
    
    self.makeIcon(homeNav, title: "Home", iconType: FAType.FAHome)
    self.makeIcon(personalNav, title:"User", iconType: FAType.FAUserSecret)
    self.makeIcon(webviewNav, title:"Web", iconType: FAType.FASafari)
    
    viewControllers = [homeNav, webviewNav, personalNav]
  }
  
  func makeIcon(controller: UINavigationController, title: String, iconType: FAType) {
    let size = CGSizeMake(40, 40)
    controller.tabBarItem.setFAIcon(iconType, customSize: size)
    controller.tabBarItem.title = title
  }
}
