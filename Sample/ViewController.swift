//
//  ViewController.swift
//  MaterialButton
//
//  Created by Kosuke Kito on 2015/06/29.
//  Copyright (c) 2015年 Kosuke Kito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var plusButton: MaterialButton! {
        didSet {
            plusButton.layer.cornerRadius = plusButton.bounds.size.width / 2
            plusButton.layer.shadowOffset = CGSizeMake(0, 10)
            plusButton.layer.shadowRadius = 4
            plusButton.layer.shadowOpacity = 0.2
        }
    }
    @IBOutlet weak var xButton: MaterialButton! {
        didSet {
            // You can change ripple color.
            xButton.rippleColor = UIColor.lightGrayColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

