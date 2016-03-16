//
//  LoginController.swift
//  ios-app-startkit
//
//  Created by Boom.Lee on 3/15/16.
//  Copyright © 2016 Boom.Lee. All rights reserved.
//
import UIKit
import SnapKit
import HexColors

class LoginController: ViewController {

  var titleLabel: UILabel!
  var nameField: UITextField!
  var passwordField: UITextField!
  var button: UIButton!
  
  var rootDelegate: RootController!
  
  let TITLE = "Welcome"
  let P_USERNAME = "Please Enter Username"
  let P_PASSWORD = "Please Enter Password"
  
  let nc = NSNotificationCenter.defaultCenter()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.addBackground("login.jpeg")
    initView()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  func initView() {
    
    titleLabel = UILabel()
    titleLabel.text = "Welcome"
    titleLabel.textAlignment = .Center
    titleLabel.font = UIFont.systemFontOfSize(24)
    view.addSubview(titleLabel)
    titleLabel.snp_makeConstraints() {
      (make) in
      make.centerX.equalTo(view)
      make.centerY.equalTo(view)
    }
    
    
    nameField = UITextField()
    self.setTextFieldStyle(P_USERNAME, textFiled: nameField)
    
    view.addSubview(nameField)
    nameField.snp_makeConstraints() {
      (make) in
      make.width.equalTo(view).offset(-140)
      make.height.equalTo(40)
      make.centerX.equalTo(view)
      make.centerY.equalTo(view).offset(70)
    }
    
    
    passwordField = UITextField()
    self.setTextFieldStyle(P_PASSWORD, textFiled: passwordField)
    passwordField.secureTextEntry = true
    
    view.addSubview(passwordField)
    passwordField.snp_makeConstraints() {
      (make) in
      make.width.equalTo(view).offset(-140)
      make.height.equalTo(40)
      make.centerX.equalTo(view)
      make.centerY.equalTo(view).offset(140)
    }
    
    
    button = UIButton()
    button.addTarget(self, action: "login", forControlEvents: UIControlEvents.TouchUpInside)
    button.setTitle("Enter", forState: UIControlState.Normal)
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
  
  func login() {
    print("Login success")
    
    if let username = self.nameField.text {
      UserStore.set("username", value: username)
      print("Username: " + username)
      
      nc.postNotification(NSNotification(name: "appLoginOperation", object: nil))
    }
  }
  
  func setTextFieldStyle(placeholder: String, textFiled: UITextField) {
    let grayColor = UIColor(hex: "#333")
    
    textFiled.backgroundColor = UIColor.whiteColor()
    textFiled.borderStyle = UITextBorderStyle.None
    textFiled.layer.cornerRadius = 4
    textFiled.layer.borderWidth = 1
    textFiled.layer.borderColor = grayColor?.CGColor
    
    textFiled.placeholder = placeholder
    textFiled.setValue(grayColor, forKeyPath: "_placeholderLabel.textColor")
    textFiled.textAlignment = .Center
  }
}
