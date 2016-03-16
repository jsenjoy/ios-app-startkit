//
//  Store.swift
//  ios-app-startkit
//
//  Created by Boom.Lee on 3/15/16.
//  Copyright © 2016 Boom.Lee. All rights reserved.
//

import UIKit

class UserStore {
  static let userDefaults = NSUserDefaults.standardUserDefaults()
  
  static func set(key: String, value: AnyObject) {
    remove(key)
    userDefaults.setObject(value, forKey: key)
    userDefaults.synchronize()
  }
  
  static func get(key: String) -> AnyObject? {
    return userDefaults.objectForKey(key)
  }
  
  static func has(key: String) -> Bool {
    return get(key) == nil ? false : true
  }
  
  static func remove(key: String) {
    userDefaults.removeObjectForKey(key)
    userDefaults.synchronize()
  }
}
