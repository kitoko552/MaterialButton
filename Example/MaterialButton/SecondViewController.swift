//
//  SecondViewController.swift
//  MaterialButton
//
//  Created by Kosuke Kito on 2015/06/30.
//  Copyright (c) 2015年 Kosuke Kito. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
  @IBOutlet weak var xButton: MaterialButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func xTapped(sender: MaterialButton) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}
