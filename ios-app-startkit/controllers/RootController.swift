//
//  RootController.swift
//  ios-app-startkit
//
//  Created by Boom.Lee on 3/16/16.
//  Copyright © 2016 Boom.Lee. All rights reserved.
//

import UIKit

class RootController: UIViewController {
  let nc = NSNotificationCenter.defaultCenter()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    nc.addObserverForName("appLoginOperation", object: nil, queue: nil) { _ in
      self.login()
    }
    
    nc.addObserverForName("appLogoutOperation", object: nil, queue: nil) { _ in
      self.logout()
    }
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    if UserStore.get("username") == nil {
      self.presentViewController(LoginController(), animated: true, completion: nil)
    } else {
      self.presentViewController(TabBarController(), animated: true, completion: nil)
    }
  }
  
  func login() {
    self.dismissViewControllerAnimated(false, completion: nil)
  }
  
  func logout() {
    self.dismissViewControllerAnimated(false, completion: nil)
  }
}
