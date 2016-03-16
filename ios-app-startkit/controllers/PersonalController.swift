//
//  PersonalController.swift
//  ios-app-startkit
//
//  Created by Boom.Lee on 3/15/16.
//  Copyright © 2016 Boom.Lee. All rights reserved.
//

import UIKit
import SnapKit

class PersonalController: ViewController {
  
  var button: UIButton!
  
  let nc = NSNotificationCenter.defaultCenter()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.title = "退出君"
    self.addBackground("logout.jpeg")
    initView()
  }
  
  func initView() {
    button = UIButton()
    button.addTarget(self, action: "logout", forControlEvents: UIControlEvents.TouchUpInside)
    button.setTitle("Logout", forState: UIControlState.Normal)
    button.layer.cornerRadius = 4
    button.backgroundColor = UIColor(hex: "#5eb95e")
    view.addSubview(button)
    button.snp_makeConstraints() {
      (make) in
      make.width.equalTo(view).offset(-140)
      make.height.equalTo(40)
      make.centerX.equalTo(view)
      make.centerY.equalTo(view).offset(210)
    }
  }
  
  func logout() {
    print("Logout success")
    print(UserStore.get("username"))
    
    UserStore.remove("username")
    
    nc.postNotification(NSNotification(name: "appLogoutOperation", object: nil))
  }
}
