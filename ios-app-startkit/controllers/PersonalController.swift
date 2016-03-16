//
//  PersonalController.swift
//  ios-app-startkit
//
//  Created by Boom.Lee on 3/15/16.
//  Copyright © 2016 Boom.Lee. All rights reserved.
//

import UIKit
import SnapKit
import HexColors

class PersonalController: ViewController, UIGestureRecognizerDelegate {
  
  var button: UIButton!
  var avatar: UIImageView!
  var wrapper: UIView!
  var layer: CAShapeLayer!
  var timer: NSTimer!
  
  let nc = NSNotificationCenter.defaultCenter()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.title = "退出君"
//    self.addBackground("logout.jpeg")
    initView()
    initAvatar()
    bindEvents()
    drawCircle()
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
  
  func initAvatar() {
    wrapper = UIView()
    view.addSubview(wrapper)
    wrapper.snp_makeConstraints() {
      (make) in
      make.width.equalTo(200)
      make.height.equalTo(200)
      make.center.equalTo(view)
    }
    
    let image = UIImage(named: "avatar.jpeg")
    avatar = UIImageView(image: image)
    avatar.layer.masksToBounds = true
    avatar.layer.cornerRadius = 100
    avatar.contentMode = UIViewContentMode.ScaleToFill
    
    wrapper.addSubview(avatar)
    
    avatar.snp_makeConstraints() {
      (make) in
      make.width.equalTo(200)
      make.height.equalTo(200)
      make.center.equalTo(view)
    }
  }
  
  func bindEvents() {
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: "longPressHandler:")
    longPressGesture.minimumPressDuration = 1.0
    longPressGesture.delegate = self
    wrapper.addGestureRecognizer(longPressGesture)
  }
  
  func drawCircle() {
    let path = UIBezierPath(arcCenter: view.center, radius: 101, startAngle: CGFloat(-M_PI / 2.0), endAngle: CGFloat(M_PI / 2.0), clockwise: true)
    
    layer = CAShapeLayer()
    layer.frame = view.bounds
    layer.strokeColor = UIColor(hex: "#5eb95e")!.CGColor
    layer.fillColor = UIColor.clearColor().CGColor
    layer.lineCap = kCALineCapSquare
    layer.path = path.CGPath
    layer.lineWidth = 4.0
    layer.strokeStart = 0.0
    layer.strokeEnd = 0.0
    
    view.layer.addSublayer(layer)
    startTimer(false)
  }
  
  func startTimer(reverse: Bool) {
    let selector = reverse ? "reverseCircle" : "updateCircle"
    timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector(selector), userInfo: nil, repeats: true)
  }
  
  func stopTimer() {
    timer.invalidate()
    timer = nil
  }
  
  func updateCircle() {
    layer.strokeEnd += 0.01
    
    if layer.strokeEnd == 1 {
      self.stopTimer()
    }
  }
  
  func reverseCircle() {
    layer.strokeEnd -= 0.01
    
    if layer.strokeEnd == 0 {
      self.stopTimer()
    }
  }
  
  func logout() {
    print("Logout success")
    print(UserStore.get("username"))
    
    UserStore.remove("username")
    
    nc.postNotification(NSNotification(name: "appLogoutOperation", object: nil))
  }
  
  func longPressHandler(gestureRecognizer: UILongPressGestureRecognizer) {
    if gestureRecognizer.state == .Began {
      stopTimer()
    }
    
    if gestureRecognizer.state == .Ended {
      startTimer(true)
    }
  }
}
