//
//  ViewController.swift
//  MaterialButton
//
//  Created by Kosuke Kito on 2015/06/29.
//  Copyright (c) 2015年 Kosuke Kito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var plusButton: MaterialButton!
  @IBOutlet weak var xButton: MaterialButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Circlize the button
    plusButton.layer.cornerRadius = plusButton.bounds.size.width / 2
    plusButton.layer.shadowOffset = CGSizeMake(0, 10)
    plusButton.layer.shadowRadius = 4
    plusButton.layer.shadowOpacity = 0.2
    
    // You can change ripple color.
    xButton.rippleColor = UIColor.lightGrayColor()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}

