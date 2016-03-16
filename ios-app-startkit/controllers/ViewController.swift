//
//  ViewController.swift
//  ios-app-startkit
//
//  Created by Boom.Lee on 3/16/16.
//  Copyright © 2016 Boom.Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func addBackground(name: String) {
    let image = UIImage(named: name)
    let imageView = UIImageView(image: image)
    imageView.frame = view.bounds
    view.addSubview(imageView)
  }
}
